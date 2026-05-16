# LocationHolidaysApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createLocationHolidayApiV1LocationHolidaysPost**](LocationHolidaysApi.md#createLocationHolidayApiV1LocationHolidaysPost) | **POST** /api/v1/location-holidays/ | Create location holiday |
| [**deleteLocationHolidayApiV1LocationHolidaysLocationHolidayIdDelete**](LocationHolidaysApi.md#deleteLocationHolidayApiV1LocationHolidaysLocationHolidayIdDelete) | **DELETE** /api/v1/location-holidays/{location_holiday_id} | Delete location holiday |
| [**getLocationHolidayApiV1LocationHolidaysLocationHolidayIdGet**](LocationHolidaysApi.md#getLocationHolidayApiV1LocationHolidaysLocationHolidayIdGet) | **GET** /api/v1/location-holidays/{location_holiday_id} | Get location holiday by ID |
| [**listLocationHolidaysApiV1LocationHolidaysGet**](LocationHolidaysApi.md#listLocationHolidaysApiV1LocationHolidaysGet) | **GET** /api/v1/location-holidays/ | List location holidays |
| [**updateLocationHolidayApiV1LocationHolidaysLocationHolidayIdPut**](LocationHolidaysApi.md#updateLocationHolidayApiV1LocationHolidaysLocationHolidayIdPut) | **PUT** /api/v1/location-holidays/{location_holiday_id} | Update location holiday |


<a name="createLocationHolidayApiV1LocationHolidaysPost"></a>
# **createLocationHolidayApiV1LocationHolidaysPost**
> BaseResponse createLocationHolidayApiV1LocationHolidaysPost(LocationHolidayCreate)

Create location holiday

    Create a new location-specific holiday.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **LocationHolidayCreate** | [**LocationHolidayCreate**](../Models/LocationHolidayCreate.md)|  | |

### Return type

[**BaseResponse**](../Models/BaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deleteLocationHolidayApiV1LocationHolidaysLocationHolidayIdDelete"></a>
# **deleteLocationHolidayApiV1LocationHolidaysLocationHolidayIdDelete**
> BaseResponse deleteLocationHolidayApiV1LocationHolidaysLocationHolidayIdDelete(location\_holiday\_id, LocationHolidayDeleteRequest)

Delete location holiday

    Delete a location holiday by ID.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_holiday\_id** | **Integer**|  | [default to null] |
| **LocationHolidayDeleteRequest** | [**LocationHolidayDeleteRequest**](../Models/LocationHolidayDeleteRequest.md)|  | |

### Return type

[**BaseResponse**](../Models/BaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="getLocationHolidayApiV1LocationHolidaysLocationHolidayIdGet"></a>
# **getLocationHolidayApiV1LocationHolidaysLocationHolidayIdGet**
> BaseResponse getLocationHolidayApiV1LocationHolidaysLocationHolidayIdGet(location\_holiday\_id)

Get location holiday by ID

    Get a single location holiday by location_holiday_id.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_holiday\_id** | **Integer**|  | [default to null] |

### Return type

[**BaseResponse**](../Models/BaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listLocationHolidaysApiV1LocationHolidaysGet"></a>
# **listLocationHolidaysApiV1LocationHolidaysGet**
> BaseResponse listLocationHolidaysApiV1LocationHolidaysGet(location\_id)

List location holidays

    List location holidays. Optionally filter by location_id. - **location_id**: If provided, returns only holidays for that location.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**| Filter by location (optional) | [optional] [default to null] |

### Return type

[**BaseResponse**](../Models/BaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateLocationHolidayApiV1LocationHolidaysLocationHolidayIdPut"></a>
# **updateLocationHolidayApiV1LocationHolidaysLocationHolidayIdPut**
> BaseResponse updateLocationHolidayApiV1LocationHolidaysLocationHolidayIdPut(location\_holiday\_id, LocationHolidayUpdate)

Update location holiday

    Update an existing location holiday (partial update).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_holiday\_id** | **Integer**|  | [default to null] |
| **LocationHolidayUpdate** | [**LocationHolidayUpdate**](../Models/LocationHolidayUpdate.md)|  | |

### Return type

[**BaseResponse**](../Models/BaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

