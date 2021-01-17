codeunit 50160 UPCATest
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure TestUPCAEncoding();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        EncodedText: text;
        ExpectedResult: text;

    begin
        // [Scenario] A barcode needs to be encoded with UPC-A
        // [Given] A font encoder initialized for UPC-A

        InitializeEncoder(TempBarcodeParameters);

        // [When] A string is encoded
        TempBarcodeParameters."Input String" := '123456789012';
        EncodedText := TempBarcodeParameters.EncodeBarcodeFont();

        // [Then] The encoded text should be as expected
        ExpectedResult := 'V(b23456*RSTKLm(W';
        Assert.AreEqual(ExpectedResult, EncodedText, 'The encoded text was incorrect. Was: ' + EncodedText + ', but should be: ' + ExpectedResult);

    end;

    [Test]
    procedure TestUPCAValidationWithEmptyString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-A
        // [Given] A font encoder initialized for UPC-A

        InitializeEncoder(TempBarcodeParameters);

        // [When] An empty string is validated
        TempBarcodeParameters."Input String" := '';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy UPC-A';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestUPCAValidationWithNullString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-A
        // [Given] A font encoder initialized for UPC-A

        InitializeEncoder(TempBarcodeParameters);

        // [When] A null string is validated        

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String  contains invalid characters for the chosen provider Default Provider and encoding symbolgy UPC-A';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestUPCAValidationWithNormalString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedResult: Boolean;
        test: Integer;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-A
        // [Given] A font encoder initialized for UPC-A

        InitializeEncoder(TempBarcodeParameters);

        // [When] A normal string is validated
        TempBarcodeParameters."Input String" := '123456789012';
        test := StrLen(TempBarcodeParameters."Input String");
        DidValidationSucceed := TempBarcodeParameters.ValidateInputString();


        // [Then] The validation should succeed
        ExpectedResult := true;
        Assert.AreEqual(ExpectedResult, DidValidationSucceed, 'The validation result was incorrect.');

    end;


    [Test]
    procedure TestUPCAValidationWithInvalidString();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-A
        // [Given] A font encoder initialized for UPC-A

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := 'abcd';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String abcd contains invalid characters for the chosen provider Default Provider and encoding symbolgy UPC-A';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    [Test]
    procedure TestUPCAValidationWithInvalidStringLength();
    var
        TempBarcodeParameters: record BarcodeParameters temporary;
        DidValidationSucceed: Boolean;
        ExpectedErrorText: Text;

    begin
        // [Scenario] A barcode string needs to be validated for UPC-A
        // [Given] A font encoder initialized for UPC-A

        InitializeEncoder(TempBarcodeParameters);

        // [When] An invalid string is validated
        TempBarcodeParameters."Input String" := '1234567';

        // [Then] The validation should raise an error
        ExpectedErrorText := 'Input String 1234567 contains invalid characters for the chosen provider Default Provider and encoding symbolgy UPC-A';
        asserterror DidValidationSucceed := TempBarcodeParameters.ValidateInputString();
        Assert.AreEqual(ExpectedErrorText, GetLastErrorText(), 'The operation did not raise the correct error');

    end;

    procedure InitializeEncoder(var TempBarcodeParameters: record BarcodeParameters temporary);
    var

    begin
        TempBarcodeParameters.Init();
        TempBarcodeParameters.Provider := TempBarcodeParameters.Provider::default;
        TempBarcodeParameters.Symbology := TempBarcodeParameters.Symbology::"upc-a";
    end;


}
