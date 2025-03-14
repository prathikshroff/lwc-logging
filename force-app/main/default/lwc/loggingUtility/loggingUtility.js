/**
 * @description Provides utility methods for logging events from LWC components
 */
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import saveLog from '@salesforce/apex/LoggingController.saveLog';

// Log level enum that matches the Apex enum
const LOG_LEVELS = {
    DEBUG: 'DEBUG',
    INFO: 'INFO',
    WARNING: 'WARNING',
    ERROR: 'ERROR',
};

/**
 * Logs an event with the specified log level
 * @param {string} eventName - Name of the event being logged
 * @param {string} logLevel - Severity level of the log (from LOG_LEVELS)
 * @param {string} logMessage - Additional context information
 * @param {boolean} showToast - Whether to display a toast notification (default: false)
 * @param {object} toastOptions - Options for toast notification (title, variant, mode)
 * @returns {Promise} Promise that resolves with the log operation result
 */
const logEvent = (eventName, logLevel, logMessage, showToast = false, toastOptions = {}) => {
    // Validate log level
    if (!Object.values(LOG_LEVELS).includes(logLevel)) {
        console.error(`Invalid log level: ${logLevel}. Valid levels are: ${Object.values(LOG_LEVELS).join(', ')}`);
        return Promise.reject(new Error(`Invalid log level: ${logLevel}`));
    }

    // Ensure logMessage is a string
    const logMessageString = typeof logMessage === 'object' ? JSON.stringify(logMessage) : String(logMessage || '');

    // Call Apex method to save log
    return saveLog({ eventName, logLevel, logMessage: logMessageString })
        .then(result => {
            // Show toast notification if requested
            if (showToast) {
                const component = toastOptions.component;
                if (!component) {
                    console.warn('No component provided for toast notification');
                    return result;
                }

                const title = toastOptions.title || `${logLevel} Log`;
                const message = toastOptions.message || `${eventName}: ${logMessageString}`;
                const variant = toastOptions.variant || mapLogLevelToVariant(logLevel);
                const mode = toastOptions.mode || 'dismissable';

                component.dispatchEvent(new ShowToastEvent({
                    title,
                    message,
                    variant,
                    mode
                }));
            }
            return result;
        })
        .catch(error => {
            console.error('Error logging event:', error);
            throw error;
        });
};

/**
 * Maps log level to toast notification variant
 * @param {string} logLevel - Log level from LOG_LEVELS
 * @returns {string} Toast variant
 */
const mapLogLevelToVariant = (logLevel) => {
    switch (logLevel) {
        case LOG_LEVELS.DEBUG:
        case LOG_LEVELS.INFO:
            return 'info';
        case LOG_LEVELS.WARNING:
            return 'warning';
        case LOG_LEVELS.ERROR:
            return 'error';
        default:
            return 'info';
    }
};

/**
 * Logs an info event
 * @param {string} eventName - Name of the event
 * @param {string|object} logMessage - logMessageual information
 * @param {boolean} showToast - Whether to show a toast notification
 * @param {object} toastOptions - Options for toast notification
 * @returns {Promise} Promise that resolves with the log operation result
 */
const logInfo = (eventName, logMessage, showToast = false, toastOptions = {}) => {
    return logEvent(eventName, LOG_LEVELS.INFO, logMessage, showToast, toastOptions);
};

/**
 * Logs a debug event
 * @param {string} eventName - Name of the event
 * @param {string|object} logMessage - logMessageual information
 * @param {boolean} showToast - Whether to show a toast notification
 * @param {object} toastOptions - Options for toast notification
 * @returns {Promise} Promise that resolves with the log operation result
 */
const logDebug = (eventName, logMessage, showToast = false, toastOptions = {}) => {
    return logEvent(eventName, LOG_LEVELS.DEBUG, logMessage, showToast, toastOptions);
};

/**
 * Logs a warning event
 * @param {string} eventName - Name of the event
 * @param {string|object} logMessage - logMessageual information
 * @param {boolean} showToast - Whether to show a toast notification
 * @param {object} toastOptions - Options for toast notification
 * @returns {Promise} Promise that resolves with the log operation result
 */
const logWarning = (eventName, logMessage, showToast = false, toastOptions = {}) => {
    return logEvent(eventName, LOG_LEVELS.WARNING, logMessage, showToast, toastOptions);
};

/**
 * Logs an error event
 * @param {string} eventName - Name of the event
 * @param {string|object} logMessage - logMessageual information
 * @param {boolean} showToast - Whether to show a toast notification
 * @param {object} toastOptions - Options for toast notification
 * @returns {Promise} Promise that resolves with the log operation result
 */
const logError = (eventName, logMessage, showToast = false, toastOptions = {}) => {
    return logEvent(eventName, LOG_LEVELS.ERROR, logMessage, showToast, toastOptions);
};

/**
 * Creates a logger for a specific component
 * Prefixes the component name to all event names
 * @param {string} componentName - Name of the component
 * @returns {object} Logger object with component-specific methods
 */
const createComponentLogger = (componentName) => {
    return {
        debug: (eventName, logMessage, showToast = false, toastOptions = {}) => {
            return logDebug(`${componentName}:${eventName}`, logMessage, showToast, toastOptions);
        },
        info: (eventName, logMessage, showToast = false, toastOptions = {}) => {
            return logInfo(`${componentName}:${eventName}`, logMessage, showToast, toastOptions);
        },
        warning: (eventName, logMessage, showToast = false, toastOptions = {}) => {
            return logWarning(`${componentName}:${eventName}`, logMessage, showToast, toastOptions);
        },
        error: (eventName, logMessage, showToast = false, toastOptions = {}) => {
            return logError(`${componentName}:${eventName}`, logMessage, showToast, toastOptions);
        },
        critical: (eventName, logMessage, showToast = false, toastOptions = {}) => {
            return logCritical(`${componentName}:${eventName}`, logMessage, showToast, toastOptions);
        }
    };
};

export {
    LOG_LEVELS,
    logEvent,
    logDebug,
    logInfo,
    logWarning,
    logError,
    createComponentLogger
};