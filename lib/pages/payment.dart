import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Main Payment Page with payment method selection
class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  bool saveCard = false;

  // Payment form controllers
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  final Color primaryColor = Color.fromARGB(255, 62, 101, 240);
  final Color orangeColor = Color(0xFFFF9500);

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  void _proceedToCheckout() {
    if (!_validatePayment()) {
      _showErrorSnackBar('Please fill in all required fields');
      return;
    }

    // Navigate to checkout page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          paymentMethod: selectedPaymentMethod!,
          cardNumber: selectedPaymentMethod == 'card'
              ? _cardNumberController.text
              : null,
          cardHolder: selectedPaymentMethod == 'card'
              ? _cardHolderController.text
              : null,
          expiryDate: selectedPaymentMethod == 'card'
              ? _expiryDateController.text
              : null,
          saveCard: saveCard,
        ),
      ),
    );
  }

  bool _validatePayment() {
    if (selectedPaymentMethod == null) return false;

    if (selectedPaymentMethod == 'card') {
      return _cardHolderController.text.isNotEmpty &&
          _cardNumberController.text.length >= 16 &&
          _expiryDateController.text.length >= 5 &&
          _cvvController.text.length >= 3;
    }

    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildPaymentMethodCard(
    String method,
    String title,
    IconData icon,
    Color iconColor,
  ) {
    bool isSelected = selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? orangeColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: orangeColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(
          'Card Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),

        // Card Holder Name
        _buildTextField(
          controller: _cardHolderController,
          label: 'Cardholder Name',
          icon: Icons.person_outline,
        ),
        SizedBox(height: 16),

        // Card Number
        _buildTextField(
          controller: _cardNumberController,
          label: 'Card Number',
          icon: Icons.credit_card,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            _CardNumberFormatter(),
          ],
        ),
        SizedBox(height: 16),

        // Expiry and CVV
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _expiryDateController,
                label: 'Expiration',
                icon: Icons.calendar_month,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  _ExpiryDateFormatter(),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _cvvController,
                label: 'CVV',
                icon: Icons.lock_outline,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        // Save card checkbox
        Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: saveCard,
                onChanged: (value) {
                  setState(() {
                    saveCard = value;
                  });
                },
                activeColor: orangeColor,
              ),
            ),
            Text(
              'Save this card',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: orangeColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  _buildProgressDot(true),
                  Expanded(child: Container(height: 2, color: orangeColor)),
                  _buildProgressDot(false),
                  Expanded(
                    child: Container(height: 2, color: Colors.grey[300]),
                  ),
                  _buildProgressDot(false),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select a payment method',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Payment methods
                    _buildPaymentMethodCard(
                      'paypal',
                      'PayPal',
                      FontAwesomeIcons.paypal,
                      Color(0xFF0070BA),
                    ),
                    _buildPaymentMethodCard(
                      'mastercard',
                      'Mastercard',
                      FontAwesomeIcons.ccMastercard,
                      Color(0xFFEB001B),
                    ),
                    _buildPaymentMethodCard(
                      'visa',
                      'Visa',
                      FontAwesomeIcons.ccVisa,
                      Color(0xFF1A1F71),
                    ),
                    _buildPaymentMethodCard(
                      'card',
                      'Credit/Debit Card',
                      Icons.credit_card,
                      primaryColor,
                    ),

                    // Card details form (shown only when card is selected)
                    if (selectedPaymentMethod == 'card')
                      _buildCardDetailsForm(),
                  ],
                ),
              ),
            ),

            // Bottom section with continue button
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedPaymentMethod != null
                      ? _proceedToCheckout
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressDot(bool isActive) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? orangeColor : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}

// Checkout Page - Order Review and Payment Confirmation
class CheckoutPage extends StatefulWidget {
  final String paymentMethod;
  final String? cardNumber;
  final String? cardHolder;
  final String? expiryDate;
  final bool saveCard;

  CheckoutPage({
    required this.paymentMethod,
    this.cardNumber,
    this.cardHolder,
    this.expiryDate,
    this.saveCard = false,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Color orangeColor = Color(0xFFFF9500);
  final TextEditingController _promoController = TextEditingController();

  // Order details
  final double subtotal = 6.59;
  final double shippingFee = 1.02;
  double promoDiscount = 0.0;
  String promoCode = '';

  double get grandTotal => subtotal + shippingFee - promoDiscount;

  void _applyPromoCode() {
    String code = _promoController.text.trim().toLowerCase();
    setState(() {
      if (code == 'save10') {
        promoDiscount = 1.0;
        promoCode = code.toUpperCase();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Promo code applied successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (code.isNotEmpty) {
        promoDiscount = 0.0;
        promoCode = '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid promo code'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  void _processPayment() {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: orangeColor),
                SizedBox(width: 20),
                Text('Processing payment...'),
              ],
            ),
          ),
        );
      },
    );

    // Simulate payment processing
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading dialog

      // Navigate to success page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessPage(
            orderTotal: grandTotal,
            orderNumber: 'DD20251234',
            paymentMethod: widget.paymentMethod,
          ),
        ),
      );
    });
  }

  String _getPaymentMethodDisplay() {
    switch (widget.paymentMethod) {
      case 'visa':
        return 'VISA';
      case 'mastercard':
        return 'Mastercard';
      case 'paypal':
        return 'PayPal';
      case 'card':
        return 'VISA'; // Default for generic card
      default:
        return 'Card';
    }
  }

  String _formatCardNumber(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) return '456825******52064';

    // Remove spaces and take last 4 digits
    String cleaned = cardNumber.replaceAll(' ', '');
    if (cleaned.length >= 4) {
      return '456825******${cleaned.substring(cleaned.length - 4)}';
    }
    return '456825******52064';
  }

  Widget _buildInputField(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
      ),
      child: Text(
        text.isEmpty ? '' : text,
        style: TextStyle(
          fontSize: 16,
          color: text.isEmpty ? Colors.grey[500] : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _formatCardNumber(widget.cardNumber),
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          Text(
            'VISA',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1F71), // Visa blue color
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light gray background
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Colors.white,
              child: Row(
                children: [
                  _buildProgressDot(true),
                  Expanded(child: Container(height: 2, color: orangeColor)),
                  _buildProgressDot(true),
                  Expanded(
                    child: Container(height: 2, color: Colors.grey[300]),
                  ),
                  _buildProgressDot(false),
                ],
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Payment Method Section
                      if (widget.paymentMethod == 'card') ...[
                        _buildSectionTitle('Cardholder Name'),
                        SizedBox(height: 8),
                        _buildInputField(widget.cardHolder ?? ''),
                        SizedBox(height: 20),

                        _buildSectionTitle('Card Number'),
                        SizedBox(height: 8),
                        _buildCardNumberField(),
                        SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle('Expiration'),
                                  SizedBox(height: 8),
                                  _buildInputField(
                                    widget.expiryDate ?? 'MM/YY',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle('CVV'),
                                  SizedBox(height: 8),
                                  _buildInputField(''),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Save card toggle
                        Row(
                          children: [
                            Text(
                              'Save this card',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: widget.saveCard,
                                onChanged: null, // Read-only
                                activeColor: orangeColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your card information is safe with us',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],

                      SizedBox(height: 32),

                      // Order Summary
                      _buildOrderSummary(),

                      SizedBox(height: 24),

                      // Promo Code Section
                      _buildPromoCodeSection(),

                      SizedBox(height: 32),

                      // Total price display
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 140,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _processPayment,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orangeColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Pay Now',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressDot(bool isActive) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? orangeColor : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOrderLine(
          'Medical Service Fee',
          'US \$${subtotal.toStringAsFixed(2)}',
        ),
        SizedBox(height: 12),
        _buildOrderLine(
          'Booking Fee',
          'US \$${shippingFee.toStringAsFixed(2)}',
        ),
        if (promoDiscount > 0) ...[
          SizedBox(height: 12),
          _buildOrderLine(
            'Promo Code',
            '-US \$${promoDiscount.toStringAsFixed(2)}',
            isDiscount: true,
          ),
        ],
        SizedBox(height: 16),
        Divider(color: Colors.grey[300]),
        SizedBox(height: 16),
        _buildOrderLine(
          'Total',
          'US \$${grandTotal.toStringAsFixed(2)}',
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildOrderLine(
    String label,
    String value, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isDiscount ? orangeColor : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Promo Code'),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!, width: 0.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  decoration: InputDecoration(
                    hintText: 'Enter Code Here',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: _applyPromoCode,
                child: Icon(Icons.chevron_right, color: orangeColor, size: 24),
              ),
            ],
          ),
        ),
        if (promoCode.isNotEmpty) ...[
          SizedBox(height: 8),
          Text(
            'Applied: $promoCode',
            style: TextStyle(color: orangeColor, fontSize: 12),
          ),
        ],
      ],
    );
  }
}

// Enhanced Payment Success Page
class PaymentSuccessPage extends StatelessWidget {
  final double orderTotal;
  final String orderNumber;
  final String paymentMethod;
  final Color orangeColor = Color(0xFFFF9500);

  PaymentSuccessPage({
    required this.orderTotal,
    required this.orderNumber,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              // Progress indicator
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    _buildProgressDot(true),
                    Expanded(child: Container(height: 2, color: orangeColor)),
                    _buildProgressDot(true),
                    Expanded(child: Container(height: 2, color: orangeColor)),
                    _buildProgressDot(true),
                  ],
                ),
              ),

              SizedBox(height: 32),

              Text(
                'Confirmation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              Spacer(),

              // Success Icon with animation
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: orangeColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: orangeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 48),
                ),
              ),

              SizedBox(height: 32),

              Text(
                'Successful!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 24),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Your order number is #${orderNumber}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: orangeColor,
                  ),
                ),
              ),

              SizedBox(height: 16),

              Text(
                'You will receive the order\nconfirmation email shortly',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32),

              Text(
                'Thank you for your trust.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              Spacer(),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to home or main screen
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Confirm Payment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressDot(bool isActive) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? orangeColor : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}

// Card number formatter
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      if ((i + 1) % 4 == 0 && i + 1 != newText.length) {
        buffer.write(' ');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Expiry date formatter
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    if (newText.length >= 2 && !newText.contains('/')) {
      return TextEditingValue(
        text: '${newText.substring(0, 2)}/${newText.substring(2)}',
        selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
      );
    }
    return newValue;
  }
}
