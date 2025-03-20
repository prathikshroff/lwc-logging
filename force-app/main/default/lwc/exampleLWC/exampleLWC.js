/**
 * @name              : 
 * @author            : pchannab
 * @usage             : 
 * @last modified on  : 03-19-2025
 * @last modified by  : pchannab
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   03-19-2025   pchannab   Initial Version
**/
import { LightningElement, api } from 'lwc';
import { logInfo, logDebug, logWarning, logError, createComponentLogger } from "c/loggingUtility";

export default class ExampleLWC extends LightningElement {

    @api recordId;
    data;
    error;

    //Create a new instance of the logger for this component
    logger = createComponentLogger('ExampleLWC');

    connectedCallback() {
        // Log component initialization
        this.logger.info('Initializing', { recordId: this.recordId }, false);
        
        this.loadData();
    }
    
    loadData() {
        try {
            // Log data loading start
            logInfo('DataLoad', 'Starting data load operation', false);
            
            // Replace with your data loading logic here
            this.data = { success: true };
            
            // Log successful data load
            this.logger.info('DataLoadSuccess', this.data, false);
        } catch (error) {
            // Log error with toast notification
            this.error = error;
            this.logger.error('DataLoadError', error.message, true, {
                component: this,
                title: 'Data Loading Error',
                message: 'Failed to load data. Please try again.'
            });
        }
    }
    
    handleClick() {
        try {
            // Some action that might fail
            const result = this.processData();
            
            // Log success with toast notification
            this.logger.info('ProcessSuccess', result, true, {
                component: this,
                title: 'Success',
                message: 'Data processed successfully',
                variant: 'success'
            });
        } catch (error) {
            // Log error
            this.logger.error('Processing Error', error, true, {
                component: this,
                title: 'Processing Error',
                message: 'Failed to process data. Please try again.'
            });
        }
    }
    
    processData() {
        // Sample processing logic
        return { processed: true };
    }
}