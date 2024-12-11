document.addEventListener("DOMContentLoaded", function() {
    // RUT Mask and Validation (format: 12345678-K)
    const rutField = document.querySelector("input[name='patient[rut]']");
    if (rutField) {
      rutField.addEventListener('input', function(e) {
        let rutValue = e.target.value.replace(/[^\dK]/g, '').toUpperCase(); // Remove non-numeric and non-'K' characters
  
        // Add hyphen only after 8 digits
        if (rutValue.length > 8) {
          rutValue = rutValue.substring(0, 8) + '-' + rutValue.substring(8);
        }
  
        // Ensure the value doesn't exceed 10 characters (8 digits + hyphen + 1 verification digit)
        if (rutValue.length > 10) {
          rutValue = rutValue.substring(0, 10);
        }
  
        // Validate the RUT after the input is formatted
        if (!validateRut(rutValue)) {
          rutField.setCustomValidity("Invalid RUT. Please enter a valid Chilean RUT.");
        } else {
          rutField.setCustomValidity(""); // Reset custom validity if the RUT is valid
        }
  
        e.target.value = rutValue;
        console.log(e.target.value)
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
    const rutDigits = rut.slice(0, 8); // First 8 digits
    const verificationDigit = rut[8].toUpperCase(); // Last character (either a number or 'K')
  
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
    let expectedVerificationDigit;
    if (calculatedVerificationDigit === 11) {
      expectedVerificationDigit = '0';
    } else if (calculatedVerificationDigit === 10) {
      expectedVerificationDigit = 'K';
    } else {
      expectedVerificationDigit = calculatedVerificationDigit.toString();
    }
  
    // Compare the expected verification digit with the input
    console.log(verificationDigit === expectedVerificationDigit)
    return verificationDigit === expectedVerificationDigit;
  }
  