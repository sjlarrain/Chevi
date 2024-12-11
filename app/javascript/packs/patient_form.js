document.addEventListener("DOMContentLoaded", function() {
    // RUT Mask and Validation (format: 12345678-K)
    const rutField = document.querySelector("input[name='patient[rut]']");
    if (rutField) {
      rutField.addEventListener('input', function(e) {
        let rutValue = e.target.value.replace(/[^\dK-]/g, '').toUpperCase(); // Allow numbers, K, and dash
  
        // Ensure the dash is added only after the 7th character
        if (rutValue.length > 7 && rutValue.indexOf('-') === -1) {
          rutValue = rutValue.substring(0, 7) + '-' + rutValue.substring(7);
        }
  
        // Validate the RUT
        if (!validateRut(rutValue)) {
          rutField.setCustomValidity("Invalid RUT. Please enter a valid Chilean RUT.");
          rutField.classList.add('invalid'); // Add visual feedback for invalid RUT
        } else {
          rutField.setCustomValidity(""); // Reset custom validity if the RUT is valid
          rutField.classList.remove('invalid'); // Remove visual feedback for valid RUT
        }
  
        e.target.value = rutValue;
      });
    }
  
    // Phone Number Mask (only numbers, optional '+')
    const phoneField = document.querySelector("input[name='patient[phone_number]']");
    if (phoneField) {
      phoneField.addEventListener('input', function(e) {
        let phoneValue = e.target.value.replace(/[^\+0-9]/g, '');
        if (phoneValue.length > 13) {
          phoneValue = phoneValue.substring(0, 13);
        }
        e.target.value = phoneValue;
      });
    }
  
    // Form submission validation
    const form = document.querySelector("form");
    if (form) {
      form.addEventListener('submit', function(e) {
        const rutInput = rutField.value;
        if (!validateRut(rutInput)) {
          e.preventDefault(); // Prevent form submission
          alert("Invalid RUT. Please enter a valid Chilean RUT.");
          rutField.focus();
        }
      });
    }
  });
  
  // RUT Validation Function
  function validateRut(rut) {
    // Remove non-numeric characters and the hyphen for validation
    rut = rut.replace(/[^\dK]/g, '');
  
    // Ensure RUT has 9 characters (8 digits + 1 verification digit)
    if (rut.length !== 9) {
      return false;
    }
  
    // Split RUT into digits and verification digit
    const rutDigits = rut.slice(0, 8);
    const verificationDigit = rut[8].toUpperCase();
  
    // Validate that all characters are numbers (except for the last one, which can be a number or 'K')
    if (!/^\d{8}$/.test(rutDigits) || !/^[0-9K]$/.test(verificationDigit)) {
      return false;
    }
  
    // Chilean RUT verification algorithm
    let sum = 0;
    let multiplier = 2;
  
    // Loop through digits and calculate the sum based on the RUT algorithm
    for (let i = rutDigits.length - 1; i >= 0; i--) {
      sum += parseInt(rutDigits[i]) * multiplier;
      multiplier = (multiplier === 7) ? 2 : multiplier + 1;
    }
  
    // Calculate the verification digit
    const remainder = sum % 11;
    const calculatedVerificationDigit = 11 - remainder;
  
    // Convert the calculated verification digit to the corresponding character
    let expectedVerificationDigit = (calculatedVerificationDigit === 11) ? '0' : 
                                     (calculatedVerificationDigit === 10) ? 'K' : 
                                     calculatedVerificationDigit.toString();
  
    // Compare the expected verification digit with the input
    return verificationDigit === expectedVerificationDigit;
  }
  