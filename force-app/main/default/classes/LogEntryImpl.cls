/**
 * @name              : 
 * @author            : pchannab
 * @usage             : 
 * @last modified on  : 03-11-2025
 * @last modified by  : pchannab
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   03-10-2025   pchannab   Initial Version
**/
public class LogEntryImpl extends LogAbstract {

    private Log__c logRecord;

    public LogEntryImpl(String eventName, LogLevel logLevel) {
        super(eventName, logLevel);
    }    
    
    /**
     * Validate the log entry before inserting
     * @return Boolean indicating if the log entry is valid
     */
    public override Boolean validate() {
        return String.isNotBlank(eventName) && 
               logLevel != null && 
               timestamp != null;
    }

    /**
     * Insert the log record
     * @return Boolean indicating successful insert
     */
    public override Boolean save() {
        // Validate before save
        Boolean isSuccessful;
        if (!validate()) {
            // LoggingService.logError('Invalid log entry', this);
            throw new LoggingException('Invalid log entry');
            // return false;
        }

        try {
            // Create Salesforce log record
            logRecord = new Log__c(
                UUID__c = uuid,
                Event_Name__c = eventName,
                Log_Level__c = String.valueOf(logLevel),
                Timestamp__c = timestamp,
                Log_Message__c = logMessage,
                User_ID__c = userId,
                User_Name__c = user_name
            );

            // Insert the log record
            Database.SaveResult saveResult = Database.insert(logRecord, false);

            // Check save result
            if (saveResult.isSuccess()) {
                // return true;
                isSuccessful = true;
            } else {
                // Log any database errors
                for (Database.Error error : saveResult.getErrors()) {
                    // LoggingService.logError(
                    //     'Log Save Error: ' + error.getStatusCode(), 
                    //     error.getMessage()
                    // );
                    throw new LoggingException('Log Save Error: ' + error.getStatusCode() + ' ' + error.getMessage());
                }
                // return false;
                isSuccessful = false;
            }
            return isSuccessful;
        } catch (Exception ex) {   
            System.debug(LoggingLevel.ERROR, ex.getMessage());         
            return false;
        }
    }
}