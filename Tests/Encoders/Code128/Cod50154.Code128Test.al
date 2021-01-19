codeunit 50154 Code128Test
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure TestCode128aEncoding();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters.OptionParameterString := 'a';

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '1234';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := 'Ë1234wÎ';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestCode128bEncoding();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters.OptionParameterString := 'b';

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '1234';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := 'Ì1234xÎ';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestCode128cEncoding();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters.OptionParameterString := 'c';

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '1234';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := 'Í,BrÎ';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestCode128EncodingWithNoTypeSelected();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);

        // [When] A string is encoded with no type selected
        TempBarcodeParameters."Input String" := '1234';


        // [Then] An error should be raised
        ExpectedResult := 'You must define a Code 128 codeset, this can be either auto, a, b or c';
        asserterror EncodedText := TempBarcodeParameters.EncodeBarcodeFont();
        Assert.AreEqual(ExpectedResult, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode128ValidationWithEmptyString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-128';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode128ValidationWithNullString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);

        // [When] A null string is validated        

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-128';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode128aValidationWithNormalString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters.OptionParameterString := 'a';

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '1234';
        DidValidationSucceed := TempBarcodeParameters.ValidateInputString();

        // [Then] The encoded text should be as expected
        ExpectedResult := true;
        Assert.AreEqual(ExpectedResult, DidValidationSucceed, 'The validation result was incorrect.');

    end;


    [Test]
    procedure TestCode128aValidationWithInvalidString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters.OptionParameterString := 'a';

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := 'lowercase';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String lowercase contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-128';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode128bValidationWithInvalidString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters.OptionParameterString := 'b';

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '€€€';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String €€€ contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-128';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode128cValidationWithInvalidString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode needs to be encoded with Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);
        TempBarcodeParameters.OptionParameterString := 'c';

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := 'ABC';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String ABC contains invalid characters for the chosen provider Default Provider and encoding symbolgy Code-128';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestCode128ImageEncodingNotImplemented();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        ImageText: Text;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Code128
        // [Given] A font encoder initialized for Code128

        InitializeEncoder(TempBarcodeParameters);

        // [When] An the image encoder is called

        // [Then] The call should raise an error
        ExpectedErrorText := 'Base64 Image Encoding is currently not implemented for ProviderDefault Provider and Symbology Code-128';
        asserterror ImageText := TempBarcodeParameters.EncodeBarcodeImage();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    procedure InitializeEncoder(var TempBarcodeParameters: record "Barcode Parameters" temporary);
    var

    begin
        TempBarcodeParameters.Init();
        TempBarcodeParameters.Provider := TempBarcodeParameters.Provider::default;
        TempBarcodeParameters.Symbology := TempBarcodeParameters.Symbology::Code128;
    end;


}
