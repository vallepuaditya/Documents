# LocationsApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createLocationApiV1LocationsPost**](LocationsApi.md#createLocationApiV1LocationsPost) | **POST** /api/v1/locations/ | Create Location |
| [**deleteLocationApiV1LocationsLocationIdDelete**](LocationsApi.md#deleteLocationApiV1LocationsLocationIdDelete) | **DELETE** /api/v1/locations/{location_id} | Delete Location |
| [**getLocationApiV1LocationsLocationIdGet**](LocationsApi.md#getLocationApiV1LocationsLocationIdGet) | **GET** /api/v1/locations/{location_id} | Get Location |
| [**getMyLocationsApiV1LocationsMyLocationsGet**](LocationsApi.md#getMyLocationsApiV1LocationsMyLocationsGet) | **GET** /api/v1/locations/my-locations | Get My Locations |
| [**listActiveAreasForLocationApiV1LocationsLocationIdAreasGet**](LocationsApi.md#listActiveAreasForLocationApiV1LocationsLocationIdAreasGet) | **GET** /api/v1/locations/{location_id}/areas | List Active Areas For Location |
| [**listLocationsApiV1LocationsGet**](LocationsApi.md#listLocationsApiV1LocationsGet) | **GET** /api/v1/locations/ | List Locations |
| [**updateLocationApiV1LocationsLocationIdPut**](LocationsApi.md#updateLocationApiV1LocationsLocationIdPut) | **PUT** /api/v1/locations/{location_id} | Update Location |


<a name="createLocationApiV1LocationsPost"></a>
# **createLocationApiV1LocationsPost**
> oas_any_type_not_mapped createLocationApiV1LocationsPost(LocationCreate)

Create Location

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **LocationCreate** | [**LocationCreate**](../Models/LocationCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deleteLocationApiV1LocationsLocationIdDelete"></a>
# **deleteLocationApiV1LocationsLocationIdDelete**
> oas_any_type_not_mapped deleteLocationApiV1LocationsLocationIdDelete(location\_id)

Delete Location

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getLocationApiV1LocationsLocationIdGet"></a>
# **getLocationApiV1LocationsLocationIdGet**
> oas_any_type_not_mapped getLocationApiV1LocationsLocationIdGet(location\_id)

Get Location

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getMyLocationsApiV1LocationsMyLocationsGet"></a>
# **getMyLocationsApiV1LocationsMyLocationsGet**
> oas_any_type_not_mapped getMyLocationsApiV1LocationsMyLocationsGet()

Get My Locations

    Return locations visible to the authenticated staff (from JWT location scope).

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listActiveAreasForLocationApiV1LocationsLocationIdAreasGet"></a>
# **listActiveAreasForLocationApiV1LocationsLocationIdAreasGet**
> oas_any_type_not_mapped listActiveAreasForLocationApiV1LocationsLocationIdAreasGet(location\_id)

List Active Areas For Location

    Active areas for a location (fn_resource_areas p_mode&#x3D;6) — Area dropdown when a location is selected.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listLocationsApiV1LocationsGet"></a>
# **listLocationsApiV1LocationsGet**
> oas_any_type_not_mapped listLocationsApiV1LocationsGet()

List Locations

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateLocationApiV1LocationsLocationIdPut"></a>
# **updateLocationApiV1LocationsLocationIdPut**
> oas_any_type_not_mapped updateLocationApiV1LocationsLocationIdPut(location\_id, LocationUpdate)

Update Location

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**|  | [default to null] |
| **LocationUpdate** | [**LocationUpdate**](../Models/LocationUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

