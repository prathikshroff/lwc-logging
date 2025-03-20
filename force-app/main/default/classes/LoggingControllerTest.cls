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
@isTest
private class LoggingControllerTest {

    private static final String SYS_ADMIN = 'System Administrator';


@IsTest
    static void testSaveLog() {
        User testUser = [SELECT Id, Name FROM User WHERE Profile.Name =:SYS_ADMIN LIMIT 1];
        
        Test.startTest();
        System.runAs(testUser) {
            Boolean result = LoggingController.saveLog(
                'Test Event', 
                'ERROR', 
                'Test Log Message'
            );
            Assert.areEqual(true, result, 'Test Log Message should be saved successfully');
        }
        Test.stopTest();
        
        List<Log__c> logEntries = [SELECT Id, Event_Name__c, Log_Level__c, Log_Message__c, User_Id__c, User_Name__c FROM Log__c];
        Assert.areEqual(1, logEntries.size(), 'logEntries should contain one entry');
        Log__c logEntry = logEntries[0];
        Assert.areEqual('Test Event', logEntry.Event_Name__c, 'Event Name should be "Test Event"');
        Assert.areEqual('ERROR', logEntry.Log_Level__c, 'Log Level should be ERROR');
        Assert.areEqual('Test Log Message', logEntry.Log_Message__c, 'Log Message should be "Test Log Message"');
        Assert.areEqual(testUser.Id, logEntry.User_Id__c, 'User Id should be the test user Id');
        Assert.areEqual(testUser.Name, logEntry.User_Name__c, 'User Name should be the test user Name');
    }

    @IsTest
    static void testException() {
        Boolean exceptionThrown = false;
        Test.startTest();
        try {
            LoggingController.saveLog(
                'Test Event', 
                'INVALID', 
                'test'
            );
        } catch (Exception ex) {
            exceptionThrown = true;
            Assert.areEqual(true, exceptionThrown, 'Expected exception to be thrown when saving a log with an invalid log level');
        }
        Test.stopTest();
    }
}