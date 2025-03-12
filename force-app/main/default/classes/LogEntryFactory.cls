/**
 * @name              : 
 * @author            : pchannab
 * @usage             : 
 * @last modified on  : 03-11-2025
 * @last modified by  : pchannab
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   03-11-2025   pchannab   Initial Version
**/
public class LogEntryFactory {
    
    private LogAbstract logEntry;    
    private String eventName;
    private LogLevel logLevel;
    private String message;
    private String userId;
    private String user_name;

    public static LogEntryFactory create() {
        LogEntryFactory builder = new LogEntryFactory();        
        return builder;
    }

    /**
     * Set the event name for the log entry
     * @param eventName Name of the event being logged
     * @return LogEntryFactory builder instance
     */
    public LogEntryFactory withEventName(String eventName) {
        this.eventName = eventName;
        return this;
    }
    
    /**
     * Set the log level for the log entry
     * @param logLevel Severity of the log entry
     * @return LogEntryFactory builder instance
     */
    public LogEntryFactory withLogLevel(LogLevel logLevel) {
        this.logLevel = logLevel;
        return this;
    }
    
    /**
     * Set additional context for the log entry
     * @param context Contextual information as a string
     * @return LogEntryFactory builder instance
     */
    public LogEntryFactory withLogMessage(String message) {
        this.message = message;
        return this;
    }
    
    /**
     * Set user context for the log entry
     * @param userContext Map of user-related information
     * @return LogEntryFactory builder instance
     */
    public LogEntryFactory withUserId(String userId) {
        this.userId = userId;
        return this;
    }

    public LogEntryFactory withUserName(String user_name) {
        this.user_name = user_name;
        return this;
    }
    
    /**
     * Build the log entry with all configured properties
     * @return Configured LogEntryBase instance
     */
    public LogAbstract build() {
        // Validate required fields
        if (String.isBlank(eventName)) {
            throw new LoggingException('Event name is required');
        }
        if (logLevel == null) {
            throw new LoggingException('Log level is required');
        }
        
        logEntry = new LogEntryImpl(eventName, logLevel);
        // Create the appropriate log entry type
        // switch on logType {
        //     when APEX {
        //         logEntry = new LogEntryImpl(eventName, logLevel);
        //     }
        //     when LWC {
        //         logEntry = new LogEntryImpl(eventName, logLevel);
        //     }
        //     // Placeholder for future log entry types
        //     when PLATFORM_EVENT {
        //         // Future implementation
        //         throw new LoggingException('Platform event log type not yet implemented');
        //     }
        //     when EXTERNAL_SYSTEM {
        //         // Future implementation
        //         throw new LoggingException('External system log type not yet implemented');
        //     }
        //     when else {
        //         throw new LoggingException('Unsupported log type');
        //     }
        // }
        
        // Set optional properties if provided
        if (String.isNotBlank(message)) {
            logEntry.setLogMessage(message);
        }
        if (String.isNotBlank(userId) && String.isNotBlank(user_name)) {
            logEntry.setUserContext(userId, user_name);            
        }
        
        return logEntry;
    }
    
    /**
     * Build and save the log entry in one operation
     * @return Boolean indicating successful log insertion
     */
    public Boolean save() {
        return build().save();
    }        
}