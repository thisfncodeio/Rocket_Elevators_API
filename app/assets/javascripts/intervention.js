// const company_name = document.getElementById("company_name");

// company_name.addEventListener("change", (e) => {
// console.log(e.target.value);
//   fetch(`/get_buildings/${e.target.value}`)
//     .then(response => response.json())
//     .then(data => console.log(data))
//     .catch(err => console.error("Error", err));
// });


$(function () {
  // console.log("Ready!");

  // If a selection has NOT been made yet
  if ($("select#customers").val() == "") { 
    // Show/Hide appropriate elements
    $("div.col-12:not(#customer-group), div#employee-group").hide();

    // Clear the option fields of all the other select fields
    $("select#buildings option").remove();
    $("select#batteries option").remove();
    $("select#columns option").remove();
    $("select#elevators option").remove();

    // Create the topmost option field for each select
    var buildingOption = "<option value=''>-- Required --</option>";
    var batteryOption = "<option value=''>-- Required --</option>";
    var columnOption = "<option value=''>-- None --</option>";
    var elevatorOption = "<option value=''>-- None --</option>";

    // Insert that option field
    $(buildingOption).appendTo("select#buildings");
    $(batteryOption).appendTo("select#batteries");
    $(columnOption).appendTo("select#columns"); 
    $(elevatorOption).appendTo("select#elevators");
  }

  // We want something to happen when the value changes
  $("select#customers").change(function () {
    // Show/Hide appropriate elements
    $("div#employee-group").show();
    $("div#building-group").show();

    // Get the value of the selected option
    var id_value_string = $(this).val();

    // If the user makes a selection but that selection is the topmost option
    // then make sure the other selection options remain empty
    if (id_value_string == "") {
      // Show/Hide appropriate elements
      $("div.col-12:not(#customer-group), div#employee-group").hide();

      // Clear the option fields of all the other select fields
      $("select#buildings option").remove();
      $("select#batteries option").remove();
      $("select#columns option").remove();
      $("select#elevators option").remove();

      // Create the topmost option field for each select
      var buildingOption = "<option value=''>-- Required --</option>";
      var batteryOption = "<option value=''>-- Required --</option>";
      var columnOption = "<option value=''>-- None --</option>";
      var elevatorOption = "<option value=''>-- None --</option>";

      // Insert that option field
      $(buildingOption).appendTo("select#buildings");
      $(batteryOption).appendTo("select#batteries");
      $(columnOption).appendTo("select#columns");
      $(elevatorOption).appendTo("select#elevators");

    // If they HAVE made an appropriate selection
    } else {
      // Send the request and update course dropdown
      $.ajax({
        dataType: "json",
        cache: false,
        url: `/get_buildings/${id_value_string}`,
        timeout: 5000,
        error: (XMLHttpRequest, errorTextStatus, error) => {
          alert(`Failed to submit: ${errorTextStatus}; ${error}`);
        },
        success: (data) => {
          // Clear the option fields of all the other select fields
          $("select#buildings option").remove();
          $("select#batteries option").remove();
          $("select#columns option").remove();
          $("select#elevators option").remove();

          // Create the topmost option field for each select
          var buildingOption = "<option value=''>-- Required --</option>";
          var batteryOption = "<option value=''>-- Required --</option>";
          var columnOption = "<option value=''>-- None --</option>";
          var elevatorOption = "<option value=''>-- None --</option>";

          // Insert that option field
          $(buildingOption).appendTo("select#buildings");
          $(batteryOption).appendTo("select#batteries");
          $(columnOption).appendTo("select#columns");
          $(elevatorOption).appendTo("select#elevators");

          // Fill course select
          $.each(data, function (i, j) {
            option = "<option value=\"" + j.id + "\">" + j.full_name_of_the_building_administrator + "</option>";
            $(option).appendTo("select#buildings");
          });
        }
      });
    }
  });

  // We want something to happen when the value changes
  $("select#buildings").change(function () {
    // Get the value of the selected option
    var id_value_string = $(this).val();

    // If the user makes a selection but that selection is the topmost option
    // then make sure the other selection options remain empty
    if (id_value_string == "") {
      // Show/Hide appropriate elements
      // $("select:not(#customers, #buildings, #employees)").hide();
      $("div.col-12:not(#customer-group, #building-group)").hide();

      // Clear the option fields of all the other select fields
      $("select#batteries option").remove();
      $("select#columns option").remove();
      $("select#elevators option").remove();

      // Create the topmost option field for each select
      var batteryOption = "<option value=''>-- Required --</option>";
      var columnOption = "<option value=''>-- None --</option>";
      var elevatorOption = "<option value=''>-- None --</option>";

      // Insert that option field
      $(batteryOption).appendTo("select#batteries");
      $(columnOption).appendTo("select#columns");
      $(elevatorOption).appendTo("select#elevators");

      // If they HAVE made an appropriate selection
    } else {
      // Show/Hide appropriate elements
      $("div#battery-group").show();

      // Send the request and update course dropdown
      $.ajax({
        dataType: "json",
        cache: false,
        url: `/get_batteries/${id_value_string}`,
        timeout: 5000,
        error: (XMLHttpRequest, errorTextStatus, error) => {
          alert(`Failed to submit: ${errorTextStatus}; ${error}`);
        },
        success: (data) => {
          // Clear the option fields of all the other select fields
          $("select#batteries option").remove();
          $("select#columns option").remove();
          $("select#elevators option").remove();

          // Create the topmost option field for each select
          var batteryOption = "<option value=''>-- Required --</option>";
          var columnOption = "<option value=''>-- None --</option>";
          var elevatorOption = "<option value=''>-- None --</option>";

          // Insert that option field
          $(batteryOption).appendTo("select#batteries");
          $(columnOption).appendTo("select#columns");
          $(elevatorOption).appendTo("select#elevators");

          // Fill course select
          $.each(data, function (i, j) {
            option = "<option value=\"" + j.id + "\">" + j.id + "</option>";
            $(option).appendTo("select#batteries");
          });
        }
      });
    }
  });

  // We want something to happen when the value changes
  $("select#batteries").change(function () {
    // Get the value of the selected option
    var id_value_string = $(this).val();

    // If the user makes a selection but that selection is the topmost option
    // then make sure the other selection options remain empty
    if (id_value_string == "") {
      // Show/Hide appropriate elements
      $("div.col-12:not(#customer-group, #building-group, #battery-group)").hide();

      // Clear the option fields of all the other select fields
      $("select#columns option").remove();
      $("select#elevators option").remove();

      // Create the topmost option field for each select
      var columnOption = "<option value=''>-- None --</option>";
      var elevatorOption = "<option value=''>-- None --</option>";

      // Insert that option field
      $(columnOption).appendTo("select#columns");
      $(elevatorOption).appendTo("select#elevators");

      // If they HAVE made an appropriate selection
    } else {
      // Show/Hide appropriate elements
      $("div#column-group").show();

      // Send the request and update course dropdown
      $.ajax({
        dataType: "json",
        cache: false,
        url: `/get_columns/${id_value_string}`,
        timeout: 5000,
        error: (XMLHttpRequest, errorTextStatus, error) => {
          alert(`Failed to submit: ${errorTextStatus}; ${error}`);
        },
        success: (data) => {
          // Clear the option fields of all the other select fields
          $("select#columns option").remove();
          $("select#elevators option").remove();

          // Create the topmost option field for each select
          var columnOption = "<option value=''>-- None --</option>";
          var elevatorOption = "<option value=''>-- None --</option>";

          // Insert that option field
          $(columnOption).appendTo("select#columns");
          $(elevatorOption).appendTo("select#elevators");

          // Fill course select
          $.each(data, function (i, j) {
            option = "<option value=\"" + j.id + "\">" + j.id + "</option>";
            $(option).appendTo("select#columns");
          });
        }
      });
    }
  });

  // We want something to happen when the value changes
  $("select#columns").change(function () {
    // Get the value of the selected option
    var id_value_string = $(this).val();

    // If the user makes a selection but that selection is the topmost option
    // then make sure the other selection options remain empty
    if (id_value_string == "") {
      // Show/Hide appropriate elements
      $("div.col-12#elevator-group").hide();

      // Clear the option fields of all the other select fields
      $("select#elevators option").remove();

      // Create the topmost option field for each select
      var elevatorOption = "<option value=''>-- None --</option>";

      // Insert that option field
      $(elevatorOption).appendTo("select#elevators");

      // If they HAVE made an appropriate selection
    } else {
      // Show/Hide appropriate elements
      $("div.col-12#elevator-group").show();

      // Send the request and update course dropdown
      $.ajax({
        dataType: "json",
        cache: false,
        url: `/get_elevators/${id_value_string}`,
        timeout: 5000,
        error: (XMLHttpRequest, errorTextStatus, error) => {
          alert(`Failed to submit: ${errorTextStatus}; ${error}`);
        },
        success: (data) => {
          // Clear the option fields of all the other select fields
          $("select#elevators option").remove();

          // Create the topmost option field for each select
          var elevatorOption = "<option value=''>-- None --</option>";

          // Insert that option field
          $(elevatorOption).appendTo("select#elevators");

          // Fill course select
          $.each(data, function (i, j) {
            option = "<option value=\"" + j.id + "\">" + j.id + "</option>";
            $(option).appendTo("select#elevators");
          });
        }
      });
    }
  });

});
