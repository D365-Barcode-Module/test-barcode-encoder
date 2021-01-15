codeunit 50153 Code93Test
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure TestCode93Encoding();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code93
        // [Given] A font encoder initialized for Code93

        InitializeEncoder(TempBarcodeParameters);

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '1234';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := '(1234K3)';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestCode93ValidationWithEmptyString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Code93
        // [Given] A font encoder initialized for Code93

        InitializeEncoder(TempBarcodeParameters);

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-93';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode93ValidationWithNullString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Code93
        // [Given] A font encoder initialized for Code93

        InitializeEncoder(TempBarcodeParameters);

        // [When] A null string is validated        

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-93';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode93ValidationWithNormalString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;

    begin
        // [Scenario] A barcode string needs to be validated for Code93
        // [Given] A font encoder initialized for Code93

        InitializeEncoder(TempBarcodeParameters);

        // [When] A normal string is validated
        TempBarcodeParameters."Input String" := '1234';
        DidValidationSucceed := TempBarcodeParameters.ValidateInputString();

        // [Then] The validation should succeed
        ExpectedResult := true;
        Assert.AreEqual(ExpectedResult, DidValidationSucceed, 'The validation result was incorrect.');

    end;

    [Test]
    procedure TestCode93ValidationWithNormalStringExtCharSet();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;

    begin
        // [Scenario] A barcode string needs to be validated for Code93
        // [Given] A font encoder initialized for Code93

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters."Allow Extended Charset" := true;

        // [When] A normal string is validated
        TempBarcodeParameters."Input String" := '1234abcd';
        DidValidationSucceed := TempBarcodeParameters.ValidateInputString();

        // [Then] The validation should succeed
        ExpectedResult := true;
        Assert.AreEqual(ExpectedResult, DidValidationSucceed, 'The validation result was incorrect.');

    end;


    [Test]
    procedure TestCode93ValidationWithInvalidString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Code93
        // [Given] A font encoder initialized for Code93

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '&&&&&&&';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String &&&&&&& contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-93';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    procedure InitializeEncoder(var TempBarcodeParameters: record BarcodeParameters temporary);
    var

    begin
        TempBarcodeParameters.Init();
        TempBarcodeParameters.Provider := TempBarcodeParameters.Provider::default;
        TempBarcodeParameters.Symbology := TempBarcodeParameters.Symbology::Code93;
    end;


}
