/**
Author:         Paul Lucas
Company:        Salesforce
Description:    qsyd_InvocableEmailActionTest
Date:           18-Nov-2018

History:
     When           Who                                     What
     24-Jun-2020    Steve Jenkins (Azimuth DS LLC)          Added dynamic test data (Contact, ContentVersion,Case, Org-Wide Email Address) creation to allow deployment in Production orgs

TODO:
*/

@IsTest
public with sharing class qsyd_InvocableEmailActionTest {
    
    private static final String ACCOUNT = 'Account';
    private static final String CONTACT = 'Contact';
    private static final String USER = 'User';
    
    private static  String CONTACT_EXAMPLE = '0034P00002PYwXAQA1';
    private static String CONTENTVERSION_EXAMPLES = '0684P00000ARbLNQA1,0684P00000ARbLIQA1';
    private static String CASE_EXAMPLE = '5004P00000XFXikQAH';
    private static final String EMAIL_EXAMPLE = '02s4P00000lnXqBQAU';
    private static final String INREPLYTO_EXAMPLE = 'topic/2734@dsalesforce.com';
    private static String ORGWIDEEMAILADDRESS_EXAMPLE = '0D24P000002AHEMSA4';
    
    static Account testAccount;
    static Contact emailContact;
    
    @TestSetup
    private static void setupTestData() {
        // Insert an account
        
    }
    
    @IsTest
    private static void initialiseSetupTestData() {
        
    }
    
    @IsTest
    private static void given_requiredEmailParametersAreProvided_when_anEmailIsInstantiated_then_anEmailIsSent() {
        qsyd_InvocableEmailAction.InvocableEmailParam param = new qsyd_InvocableEmailAction.InvocableEmailParam();
        List<qsyd_InvocableEmailAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailAction.InvocableEmailParam>();
        
        testAccount = new Account(Name = 'Test Account');
        INSERT testAccount;
         // 06242020 - Azimuth DS LLC - STJ -- Create Contact record begin
        emailContact = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'plucas@salesforce.com');
        insert emailContact;
        CONTACT_EXAMPLE = emailContact.Id;
        // 06242020 - Azimuth DS LLC - STJ -- Create Contact record end
         
         // 06242020 - Azimuth DS LLC - STJ -- Create ContentVersion records begin
        ContentVersion cv = new Contentversion(); 
        cv.Title = 'CZDSTOU1'; 
        cv.PathOnClient = 'test1'; 
        cv.VersionData = EncodingUtil.base64Decode('Unit Test Attachment Body part 1'); 
        List<ContentVersion> cvlist = new List<ContentVersion>(); 
        cvlist.add(cv); 
        cv = new Contentversion(); 
        cv.Title = 'CZDSTOU2'; 
        cv.PathOnClient = 'test2'; 
        cv.VersionData = EncodingUtil.base64Decode('Unit Test Attachment Body part 2'); 
        cvlist.add(cv); 
        insert cvlist;
        CONTENTVERSION_EXAMPLES = cvlist[0].Id + ',' + cvlist[1].Id;
         // 06242020 - Azimuth DS LLC - STJ -- Create ContentVersion records end
        
        // 06242020 - Azimuth DS LLC - STJ -- Create Case record begin
        Case testCase = new Case(Origin='Phone');
        insert testCase;
        CASE_EXAMPLE = testCase.Id;
         // 06242020 - Azimuth DS LLC - STJ -- Create Case record end
         
         // 06242020 - Azimuth DS LLC - STJ -- Retrieve Org-Wide Email Address to use in test begin
        List<OrgWideEmailAddress> orgAddressList = [select id, Address, DisplayName from OrgWideEmailAddress];
        system.debug(orgAddressList.size());
        ORGWIDEEMAILADDRESS_EXAMPLE = orgAddressList.size() > 0 ? orgAddressList[0].Address : ORGWIDEEMAILADDRESS_EXAMPLE;
        // 06242020 - Azimuth DS LLC - STJ -- Retrieve Org-Wide Email Address to use in test end
        
        Test.startTest();
        
        param.toAddress = 'plucas@salesforce.com';
        param.ccAddress = 'test_email@gmail.com';
        param.bccAddress = 'test_email@gmail.com';
        param.throwExceptionForSendErrors = true;
        param.subject = 'Email Subject';
        param.bodyPlainText = 'Plain text body';
        param.bodyHtml = '<html><body><strong>Rich text body</strong></body></html>';
        param.charSet = 'utf-8';
        param.attachmentIds = CONTENTVERSION_EXAMPLES;
        param.whatId = CASE_EXAMPLE;
        //param.parentMessageIds = INREPLYTO_EXAMPLE; // 06242020 - Azimuth DS LLC - STJ -- Commented out as it is not necessary for the test
        param.orgWideEmailAddress = ORGWIDEEMAILADDRESS_EXAMPLE;
        param.emailOptOutPolicy = 'FILTER';
        param.saveAsActivity = true;
        params.add(param);
        
        List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailAction.sendEmail(params);
        Integer invocations = Limits.getEmailInvocations();
        
        // Email was sent
        System.assertEquals(1, invocations);
        
        Test.stopTest();
    }
    
    @IsTest
    private static void given_noRecipientsAreProvided_when_anEmailIsInstantiated_then_anExceptionIsThrown() {
        qsyd_InvocableEmailAction.InvocableEmailParam param = new qsyd_InvocableEmailAction.InvocableEmailParam();
        List<qsyd_InvocableEmailAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailAction.InvocableEmailParam>();
        Integer exceptions = 0;
        
        initialiseSetupTestData();
        
        Test.startTest();
        
        param.bodyPlainText = 'plain text body';
        params.add(param);
        
        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailAction.sendEmail(params);
        } catch (Exception e) {
            exceptions++;
        }
        
        // Exception was thrown
        System.assertEquals(1, exceptions);
        
        Test.stopTest();
    }
    
    @IsTest
    private static void given_anOrgWideEmailAddressDoesNotExist_when_anOrgWideEmailIsQueried_then_anExceptionIsThrown() {
        qsyd_InvocableEmailAction.InvocableEmailParam param = new qsyd_InvocableEmailAction.InvocableEmailParam();
        List<qsyd_InvocableEmailAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailAction.InvocableEmailParam>();
        Integer exceptions = 0;
        
        initialiseSetupTestData();
        
        Test.startTest();
        
        param.toAddress = 'plucas@salesforce.com';
        param.bodyPlainText = 'plain text body';
        param.orgWideEmailAddress = 'non_existent_email@salesforce.com';
        params.add(param);
        
        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailAction.sendEmail(params);
            
            System.debug(results);
        } catch (Exception e) {
            exceptions++;
        }
        
        // Exception was thrown
        System.assertEquals(1, exceptions);
        
        Test.stopTest();
    }
    
    @IsTest
    private static void given_anInvalidEmailIsSupplied_when_anEmailIsInstantiated_then_anEmailIsSentWithErrors() {
        qsyd_InvocableEmailAction.InvocableEmailParam param = new qsyd_InvocableEmailAction.InvocableEmailParam();
        List<qsyd_InvocableEmailAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailAction.InvocableEmailParam>();
        Integer exceptions = 0;
        
        initialiseSetupTestData();
        
        Test.startTest();
        
        param.toAddress = 'plucas';
        param.bodyPlainText = 'plain text body';
        params.add(param);
        
        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailAction.sendEmail(params);
        } catch (Exception e) {
            exceptions++;
        }
        
        // Exception was thrown
        System.assertEquals(1, exceptions);
        
        Test.stopTest();
    }
}    
