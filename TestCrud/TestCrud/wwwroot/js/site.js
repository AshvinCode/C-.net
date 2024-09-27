$(document).ready(function () {
    var useId = $("#Id").val();
    if (useId != null && useId > 0) {
        var countryId = $("#country_id").val()
        var stateId = $("#state_id").val()
        var cityId = $("#city_id").val()
        console.log("countryId", countryId);
        console.log("stateId", stateId);
        console.log("cityId", cityId);
        $('#Country').val(`${countryId}`).change();
        setTimeout(function () {
            $('#State').val(`${stateId}`).change();
            setTimeout(function () {
                $('#City').val(`${cityId}`).change();
            }, 400);
        }, 200);
    }
});
function func_getStateandCityById(e) {
    console.log(e);
    var dropDownType = e.name;
    var Id = e.value;
    // AJAX call to fetch data
    $.ajax({
        url: '/TestCrud/getStateCityByID',
        type: 'GET',
        dataType: 'json',
        data: { id: Id, type: dropDownType },
        success: function (response) {
            if (response.success) {
                console.log(response.data);
                var states = JSON.parse(response.data)
                var stateDropdown = $('#State');
                var cityDropdown = $('#City');
                //State option add
                if (dropDownType == 'Country') {
                    cityDropdown.find('option:not(:first)').remove();
                    stateDropdown.find('option:not(:first)').remove();
                    // Append new options
                    $.each(states, function (index, state) {
                        stateDropdown.append($('<option>', {
                            value: state.id,
                            text: state.name
                        }));
                    });
                }
                if (dropDownType == 'State') {
                    cityDropdown.find('option:not(:first)').remove();
                    // Append new options
                    $.each(states, function (index, state) {
                        cityDropdown .append($('<option>', {
                            value: state.id,
                            text: state.name
                        }));
                    });
                }

            } else {
                console.error(response.message);
            }
        },
        error: function (xhr, status, error) {
            console.error(error);
        }
    });
}

function func_deleteUser(e) {
    if (!confirm("Are you sure you want to delete this user?")) {
        return;
    }
    var Id = e;
    $.ajax({
        url: '/TestCrud/deleteUser',
        type: 'GET',
        dataType: 'json',
        data: { id: Id },
        success: function (response) {
            if (response.success) {
                console.log(response.data);
                location.reload();
            } else {
                console.error(response.message);
            }
        },
        error: function (xhr, status, error) {
            console.error(error);
        }
    });
}
