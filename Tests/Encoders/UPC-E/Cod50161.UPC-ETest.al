codeunit 50161 UPCETest
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure TestUPCEEncoding();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with UPC-E
        // [Given] A font encoder initialized for UPC-E

        InitializeEncoder(TempBarcodeParameters);

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '123456789012';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := 'V(b23456*RSTKLm(W';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestUPCEValidationWithEmptyString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-E
        // [Given] A font encoder initialized for UPC-E

        InitializeEncoder(TempBarcodeParameters);

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy UPC-E';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestUPCEValidationWithNullString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-E
        // [Given] A font encoder initialized for UPC-E

        InitializeEncoder(TempBarcodeParameters);

        // [When] A null string is validated        

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy UPC-E';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestUPCEValidationWithNormalString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;
        test: Integer;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-E
        // [Given] A font encoder initialized for UPC-E

        InitializeEncoder(TempBarcodeParameters);

        // [When] A normal string is validated
        TempBarcodeParameters."Input String" := '1234567';
        test := StrLen(TempBarcodeParameters."Input String");
        DidValidationSucceed := TempBarcodeParameters.ValidateInputString();


        // [Then] The validation should succeed
        ExpectedResult := true;
        Assert.AreEqual(ExpectedResult, DidValidationSucceed, 'The validation result was incorrect.');

    end;


    [Test]
    procedure TestUPCEValidationWithInvalidString();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-E
        // [Given] A font encoder initialized for UPC-E

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := 'abcd';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String abcd contains invalid characters for the chosen provider Default Provider and encoding symbolgy UPC-E';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestUPCEValidationWithInvalidStringLength();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-E
        // [Given] A font encoder initialized for UPC-E

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '1234567890';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String 1234567890 contains invalid characters for the chosen provider Default Provider and encoding symbolgy UPC-E';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestUPCEImageEncodingNotImplemented();
    var
        TempBarcodeParameters: record "Barcode Parameters" temporary;
        ImageText: Text;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPCE
        // [Given] A font encoder initialized for UPCE

        InitializeEncoder(TempBarcodeParameters);

        // [When] An the image encoder is called

        // [Then] The call should raise an error
        ExpectedErrorText := 'Base64 Image Encoding is currently not implemented for ProviderDefault Provider and Symbology UPC-E';
        asserterror ImageText := TempBarcodeParameters.EncodeBarcodeImage();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    procedure InitializeEncoder(var TempBarcodeParameters: record "Barcode Parameters" temporary);
    var

    begin
        TempBarcodeParameters.Init();
        TempBarcodeParameters.Provider := TempBarcodeParameters.Provider::default;
        TempBarcodeParameters.Symbology := TempBarcodeParameters.Symbology::"UPC-E";
    end;


}
