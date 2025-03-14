/**
 * @name              : 
 * @author            : pchannab
 * @usage             : 
 * @last modified on  : 03-14-2025
 * @last modified by  : pchannab
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   03-14-2025   pchannab   Initial Version
**/
public with sharing class LoggingController {
    
    /**
     * Save a log entry
     * @param eventName Name of the event
     * @param logLevel Log level
     * @param context Additional context
     * @return Boolean indicating success
     */
    @AuraEnabled
    public static Boolean saveLog(
        String eventName, 
        String logLevel, 
        String logMessage
    ) {
        try {                                    
            // Create and save log entry using the builder pattern
            return LogEntryFactory.create()
                .withEventName(eventName)
                .withLogLevel(convertStringToLogLevelEnum(logLevel))
                .withLogMessage(logMessage)
                .withUserId(UserInfo.getUserId())
                .withUserName(UserInfo.getName())
                .save();
                
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, 'Log save failed: ' + ex.getMessage());
            return false;
        }
    }

    private static LogLevel convertStringToLogLevelEnum(String str) {
        return LogLevel.valueOf(str);
    }
}