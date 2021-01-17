codeunit 50159 PostnetTest
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure TestPostnetEncoding();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Postnet
        // [Given] A font encoder initialized for Postnet

        InitializeEncoder(TempBarcodeParameters);

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '123456';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := '(1234569)';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestPostnetValidationWithEmptyString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Postnet
        // [Given] A font encoder initialized for Postnet

        InitializeEncoder(TempBarcodeParameters);

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Postnet';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestPostnetValidationWithNullString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Postnet
        // [Given] A font encoder initialized for Postnet

        InitializeEncoder(TempBarcodeParameters);

        // [When] A null string is validated        

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Postnet';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestPostnetValidationWithNormalString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;
        test: Integer;

    begin
        // [Scenario] A barcode string needs to be validated for Postnet
        // [Given] A font encoder initialized for Postnet

        InitializeEncoder(TempBarcodeParameters);

        // [When] A normal string is validated
        TempBarcodeParameters."Input String" := '123456';
        test := StrLen(TempBarcodeParameters."Input String");
        DidValidationSucceed := TempBarcodeParameters.ValidateInputString();


        // [Then] The validation should succeed
        ExpectedResult := true;
        Assert.AreEqual(ExpectedResult, DidValidationSucceed, 'The validation result was incorrect.');

    end;


    [Test]
    procedure TestPostnetValidationWithInvalidString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Postnet
        // [Given] A font encoder initialized for Postnet

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := 'abcd';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String abcd contains invalid characters for the chosen provider Default Provider and encoding symbolgy Postnet';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestPostnetValidationWithInvalidStringLength();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Postnet
        // [Given] A font encoder initialized for Postnet

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '1234567';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String 1234567 contains invalid characters for the chosen provider Default Provider and encoding symbolgy Postnet';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    procedure InitializeEncoder(var TempBarcodeParameters: record BarcodeParameters temporary);
    var

    begin
        TempBarcodeParameters.Init();
        TempBarcodeParameters.Provider := TempBarcodeParameters.Provider::default;
        TempBarcodeParameters.Symbology := TempBarcodeParameters.Symbology::Postnet;
    end;


}
