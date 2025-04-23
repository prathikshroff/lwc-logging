/**
 * @name              : 
 * @author            : pchannab
 * @usage             : 
 * @last modified on  : 04-22-2025
 * @last modified by  : pchannab
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   03-05-2025   pchannab   Initial Version
**/
//Abstract class to define common properties and methods for log entries
//Subclasses must implement their own validation and persistence logic.

public abstract class LogAbstract {
    protected String uuid;
    @TestVisible protected String eventName;
    @TestVisible protected LogLevel logLevel;
    @TestVisible protected Datetime timestamp;
    @TestVisible protected String logMessage;
    @TestVisible protected String userId;
    @TestVisible protected String user_name;

    // Enum to define log levels
    // public enum LogLevel {
    //     DEBUG, 
    //     INFO, 
    //     WARNING, 
    //     ERROR
    // }

    /**
     * Constructor to initialize common log entry properties
     * @param eventName Name of the event being logged
     * @param logLevel Severity of the log entry
     */
    public LogAbstract(String eventName, LogLevel logLevel) {
        this.uuid = generateUUID();
        this.eventName = eventName;
        this.logLevel = logLevel;
        this.timestamp = System.now();
        // this.userId = UserInfo.getUserId();
        // this.user_name = UserInfo.getName();
    }

    /**
     * Generate a unique identifier for the log entry
     * @return Unique UUID string
     */
    private String generateUUID() {
        return System.UUID.randomUUID().toString();
    }

    /**
     * Set additional context for the log entry
     * @param context Contextual information as a string
     * @return Current log entry instance
     */
    public LogAbstract setLogMessage(String message) {
        this.logMessage = message;
        return this;
    }

    /**
     * Set user context for the log entry
     * @param userContext Map of user-related information
     * @return Current log entry instance
     */
    public LogAbstract setUserContext(String userId, String userName) {
        this.userId = userId;
        this.user_name = userName;
        return this;
    }

    /**
     * Abstract method to validate log entry
     * Each subclass must implement its own validation logic
     * @return Boolean indicating if the log entry is valid
     */
    public abstract Boolean validate();

    /**
     * Abstract method to insert the log entry
     * Each subclass must define its own implementation/insertion logic
     * @return Boolean indicating successful insertion of the log entry
     */
    public abstract Boolean save();
}