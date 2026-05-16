# KioskLocationsApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**getKioskLocationOperatingHoursApiV1KioskLocationsLocationIdOperatingHoursGet**](KioskLocationsApi.md#getKioskLocationOperatingHoursApiV1KioskLocationsLocationIdOperatingHoursGet) | **GET** /api/v1/kiosk/locations/{location_id}/operating-hours | Operating hours for the kiosk location |


<a name="getKioskLocationOperatingHoursApiV1KioskLocationsLocationIdOperatingHoursGet"></a>
# **getKioskLocationOperatingHoursApiV1KioskLocationsLocationIdOperatingHoursGet**
> KioskLocationOperatingHoursEnvelope getKioskLocationOperatingHoursApiV1KioskLocationsLocationIdOperatingHoursGet(location\_id)

Operating hours for the kiosk location

    Returns &#x60;open_time&#x60;, &#x60;close_time&#x60;, and &#x60;time_zone&#x60; for slot generation. Uses &#x60;public.fn_locations&#x60; mode 2. The path &#x60;location_id&#x60; must match the kiosk JWT &#x60;location_id&#x60;.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**| Must match kiosk token location_id | [default to null] |

### Return type

[**KioskLocationOperatingHoursEnvelope**](../Models/KioskLocationOperatingHoursEnvelope.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

