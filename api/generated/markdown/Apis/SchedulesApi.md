# SchedulesApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**deleteLocationScheduleOverrideApiV1LocationsLocationIdScheduleOverridesOverrideIdDelete**](SchedulesApi.md#deleteLocationScheduleOverrideApiV1LocationsLocationIdScheduleOverridesOverrideIdDelete) | **DELETE** /api/v1/locations/{location_id}/schedule-overrides/{override_id} | Delete a location schedule override by id |
| [**getLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesGet**](SchedulesApi.md#getLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesGet) | **GET** /api/v1/locations/{location_id}/schedule-overrides | Get location schedule overrides for a date range |
| [**putLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesPut**](SchedulesApi.md#putLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesPut) | **PUT** /api/v1/locations/{location_id}/schedule-overrides | Bulk upsert location schedule overrides |


<a name="deleteLocationScheduleOverrideApiV1LocationsLocationIdScheduleOverridesOverrideIdDelete"></a>
# **deleteLocationScheduleOverrideApiV1LocationsLocationIdScheduleOverridesOverrideIdDelete**
> BaseResponse deleteLocationScheduleOverrideApiV1LocationsLocationIdScheduleOverridesOverrideIdDelete(location\_id, override\_id)

Delete a location schedule override by id

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**|  | [default to null] |
| **override\_id** | **Integer**|  | [default to null] |

### Return type

[**BaseResponse**](../Models/BaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesGet"></a>
# **getLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesGet**
> BaseResponse getLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesGet(location\_id, start\_date, end\_date)

Get location schedule overrides for a date range

    Returns schedule overrides for the location in [start_date, end_date].

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**|  | [default to null] |
| **start\_date** | **date**| Start date (YYYY-MM-DD) | [default to null] |
| **end\_date** | **date**| End date (YYYY-MM-DD) | [default to null] |

### Return type

[**BaseResponse**](../Models/BaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="putLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesPut"></a>
# **putLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesPut**
> BaseResponse putLocationScheduleOverridesApiV1LocationsLocationIdScheduleOverridesPut(location\_id, ScheduleOverridesBulkRequest)

Bulk upsert location schedule overrides

    Upsert schedule overrides for the location. Each item in overrides is processed via DB mode 3.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**|  | [default to null] |
| **ScheduleOverridesBulkRequest** | [**ScheduleOverridesBulkRequest**](../Models/ScheduleOverridesBulkRequest.md)|  | |

### Return type

[**BaseResponse**](../Models/BaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

