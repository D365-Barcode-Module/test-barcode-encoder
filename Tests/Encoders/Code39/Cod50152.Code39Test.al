codeunit 50152 Code39Test
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure TestCode39Encoding();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '1234';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := '!1234!';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestCode39EncodingWithChecksum();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters."Enable Checksum" := true;

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '1234';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := '!1234A! ';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestCode39EncodingWithExtCharSet();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters."Allow Extended Charset" := true;

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := 'A1234B';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := '!A1234B!';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestCode39EncodingWithChecksumAndExtCharSet();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters."Allow Extended Charset" := true;
        TempBarcodeParameters."Enable Checksum" := true;

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := 'A1234B';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := '!A1234BV! ';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestCode39ValidationWithEmptyString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-39';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode39ValidationWithNullString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);

        // [When] A null string is validated        

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-39';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode39ValidationWithNormalString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;

    begin
        // [Scenario] A barcode string needs to be validated for Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);

        // [When] A normal string is validated
        TempBarcodeParameters."Input String" := '1234';
        DidValidationSucceed := TempBarcodeParameters.ValidateInputString();

        // [Then] The validation should succeed
        ExpectedResult := true;
        Assert.AreEqual(ExpectedResult, DidValidationSucceed, 'The validation result was incorrect.');

    end;

    [Test]
    procedure TestCode39ValidationWithNormalStringExtCharSet();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;

    begin
        // [Scenario] A barcode string needs to be validated for Code39
        // [Given] A font encoder initialized for Code39

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
    procedure TestCode39ValidationWithInvalidString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '&&&&&&&';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String &&&&&&& contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-39';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode39ImageEncodingNotImplemented();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        ImageText: Text;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Code39
        // [Given] A font encoder initialized for Code39

        InitializeEncoder(TempBarcodeParameters);

        // [When] An the image encoder is called

        // [Then] The call should raise an error
        ExpectedErrorText := 'Base64 Image Encoding is currently not implemented for ProviderDefault Provider and Symbology Code-39';
        asserterror ImageText := TempBarcodeParameters.EncodeBarcodeImage();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    procedure InitializeEncoder(var TempBarcodeParameters: record "Barcode Parameters" temporary);
    var

    begin
        TempBarcodeParameters.Init();
        TempBarcodeParameters.Provider := TempBarcodeParameters.Provider::default;
        TempBarcodeParameters.Symbology := TempBarcodeParameters.Symbology::Code39;
    end;


}
