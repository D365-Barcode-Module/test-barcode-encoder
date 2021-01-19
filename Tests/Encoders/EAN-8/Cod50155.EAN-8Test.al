codeunit 50155 EAN8Test
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure TestEAN8Encoding();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with EAN-8
        // [Given] A font encoder initialized for EAN-8

        InitializeEncoder(TempBarcodeParameters);

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '1234567';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := '(1234*PQRK(';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestEAN8ValidationWithEmptyString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for EAN-8
        // [Given] A font encoder initialized for EAN-8

        InitializeEncoder(TempBarcodeParameters);

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy EAN-8';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestEAN8ValidationWithNullString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for EAN-8
        // [Given] A font encoder initialized for EAN-8

        InitializeEncoder(TempBarcodeParameters);

        // [When] A null string is validated        

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy EAN-8';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestEAN8ValidationWithNormalString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;
        test: Integer;

    begin
        // [Scenario] A barcode string needs to be validated for EAN-8
        // [Given] A font encoder initialized for EAN-8

        InitializeEncoder(TempBarcodeParameters);

        // [When] A normal string is validated
        TempBarcodeParameters."Input String" := '2345678';
        test := StrLen(TempBarcodeParameters."Input String");
        DidValidationSucceed := TempBarcodeParameters.ValidateInputString();


        // [Then] The validation should succeed
        ExpectedResult := true;
        Assert.AreEqual(ExpectedResult, DidValidationSucceed, 'The validation result was incorrect.');

    end;


    [Test]
    procedure TestEAN8ValidationWithInvalidString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for EAN-8
        // [Given] A font encoder initialized for EAN-8

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '&&&&&&&';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String &&&&&&& contains invalid characters for the chosen provider Default Provider and encoding symbolgy EAN-8';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestEAN8ValidationWithInvalidStringLength();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for EAN-8
        // [Given] A font encoder initialized for EAN-8

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '12345678901';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String 12345678901 contains invalid characters for the chosen provider Default Provider and encoding symbolgy EAN-8';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestEAN8ImageEncodingNotImplemented();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        ImageText: Text;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for EAN8
        // [Given] A font encoder initialized for EAN8

        InitializeEncoder(TempBarcodeParameters);

        // [When] An the image encoder is called

        // [Then] The call should raise an error
        ExpectedErrorText := 'Base64 Image Encoding is currently not implemented for ProviderDefault Provider and Symbology EAN-8';
        asserterror ImageText := TempBarcodeParameters.EncodeBarcodeImage();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    procedure InitializeEncoder(var TempBarcodeParameters: record "Barcode Parameters" temporary);
    var

    begin
        TempBarcodeParameters.Init();
        TempBarcodeParameters.Provider := TempBarcodeParameters.Provider::default;
        TempBarcodeParameters.Symbology := TempBarcodeParameters.Symbology::ean8;
    end;


}
