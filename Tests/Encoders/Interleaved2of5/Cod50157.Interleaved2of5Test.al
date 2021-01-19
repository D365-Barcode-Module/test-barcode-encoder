codeunit 50157 Interleaved2of5Test
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure TestInterleaved2of5Encoding();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with Interleaved2of5
        // [Given] A font encoder initialized for Interleaved2of5

        InitializeEncoder(TempBarcodeParameters);

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '123456';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := 'Ë-CYÌ';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestInterleaved2of5ValidationWithEmptyString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Interleaved2of5
        // [Given] A font encoder initialized for Interleaved2of5

        InitializeEncoder(TempBarcodeParameters);

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Interleaved 2 of 5';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestInterleaved2of5ValidationWithNullString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Interleaved2of5
        // [Given] A font encoder initialized for Interleaved2of5

        InitializeEncoder(TempBarcodeParameters);

        // [When] A null string is validated        

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy Interleaved 2 of 5';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestInterleaved2of5ValidationWithNormalString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;
        test: Integer;

    begin
        // [Scenario] A barcode string needs to be validated for Interleaved2of5
        // [Given] A font encoder initialized for Interleaved2of5

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
    procedure TestInterleaved2of5ValidationWithInvalidString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Interleaved2of5
        // [Given] A font encoder initialized for Interleaved2of5

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := 'abcd';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String abcd contains invalid characters for the chosen provider Default Provider and encoding symbolgy Interleaved 2 of 5';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestInterleaved2of5ValidationWithInvalidStringLength();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Interleaved2of5
        // [Given] A font encoder initialized for Interleaved2of5

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '12345';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String 12345 contains invalid characters for the chosen provider Default Provider and encoding symbolgy Interleaved 2 of 5';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestInterleaved2of5ImageEncodingNotImplemented();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        ImageText: Text;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for Interleaved2of5
        // [Given] A font encoder initialized for Interleaved2of5

        InitializeEncoder(TempBarcodeParameters);

        // [When] An the image encoder is called

        // [Then] The call should raise an error
        ExpectedErrorText := 'Base64 Image Encoding is currently not implemented for ProviderDefault Provider and Symbology Interleaved 2 of 5';
        asserterror ImageText := TempBarcodeParameters.EncodeBarcodeImage();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    procedure InitializeEncoder(var TempBarcodeParameters: record "Barcode Parameters" temporary);
    var

    begin
        TempBarcodeParameters.Init();
        TempBarcodeParameters.Provider := TempBarcodeParameters.Provider::default;
        TempBarcodeParameters.Symbology := TempBarcodeParameters.Symbology::Interleaved2of5;
    end;


}
