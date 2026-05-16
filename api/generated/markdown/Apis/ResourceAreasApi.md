# ResourceAreasApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createAreaApiV1AreasPost**](ResourceAreasApi.md#createAreaApiV1AreasPost) | **POST** /api/v1/areas/ | Create area |
| [**deactivateAreaApiV1AreasAreaIdDelete**](ResourceAreasApi.md#deactivateAreaApiV1AreasAreaIdDelete) | **DELETE** /api/v1/areas/{area_id} | Deactivate area |
| [**decommissionAreaApiV1AreasAreaIdDecommissionPost**](ResourceAreasApi.md#decommissionAreaApiV1AreasAreaIdDecommissionPost) | **POST** /api/v1/areas/{area_id}/decommission | Decommission area |
| [**getAreaApiV1AreasAreaIdGet**](ResourceAreasApi.md#getAreaApiV1AreasAreaIdGet) | **GET** /api/v1/areas/{area_id} | Get area by ID |
| [**listAreasApiV1AreasGet**](ResourceAreasApi.md#listAreasApiV1AreasGet) | **GET** /api/v1/areas/ | List all active areas |
| [**listAreasByLocationApiV1AreasByLocationLocationIdGet**](ResourceAreasApi.md#listAreasByLocationApiV1AreasByLocationLocationIdGet) | **GET** /api/v1/areas/by-location/{location_id} | List areas for a location |
| [**recommissionAreaApiV1AreasAreaIdRecommissionPost**](ResourceAreasApi.md#recommissionAreaApiV1AreasAreaIdRecommissionPost) | **POST** /api/v1/areas/{area_id}/recommission | Recommission area |
| [**updateAreaApiV1AreasAreaIdPut**](ResourceAreasApi.md#updateAreaApiV1AreasAreaIdPut) | **PUT** /api/v1/areas/{area_id} | Update area |


<a name="createAreaApiV1AreasPost"></a>
# **createAreaApiV1AreasPost**
> oas_any_type_not_mapped createAreaApiV1AreasPost(AreaCreate)

Create area

    Create a new resource area under a location (mode 3).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **AreaCreate** | [**AreaCreate**](../Models/AreaCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deactivateAreaApiV1AreasAreaIdDelete"></a>
# **deactivateAreaApiV1AreasAreaIdDelete**
> oas_any_type_not_mapped deactivateAreaApiV1AreasAreaIdDelete(area\_id)

Deactivate area

    Deactivate an area (mode 5). Blocked if active resources are assigned to this area.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **area\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="decommissionAreaApiV1AreasAreaIdDecommissionPost"></a>
# **decommissionAreaApiV1AreasAreaIdDecommissionPost**
> oas_any_type_not_mapped decommissionAreaApiV1AreasAreaIdDecommissionPost(area\_id, AreaActionRequest)

Decommission area

    Decommission an area — sets status to decommissioned (mode 7). Blocked if active resources are still assigned.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **area\_id** | **Integer**|  | [default to null] |
| **AreaActionRequest** | [**AreaActionRequest**](../Models/AreaActionRequest.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="getAreaApiV1AreasAreaIdGet"></a>
# **getAreaApiV1AreasAreaIdGet**
> oas_any_type_not_mapped getAreaApiV1AreasAreaIdGet(area\_id)

Get area by ID

    Get a single area by area_id (mode 2).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **area\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listAreasApiV1AreasGet"></a>
# **listAreasApiV1AreasGet**
> oas_any_type_not_mapped listAreasApiV1AreasGet()

List all active areas

    List all active resource areas (mode 1).

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listAreasByLocationApiV1AreasByLocationLocationIdGet"></a>
# **listAreasByLocationApiV1AreasByLocationLocationIdGet**
> oas_any_type_not_mapped listAreasByLocationApiV1AreasByLocationLocationIdGet(location\_id)

List areas for a location

    Filter active areas by location_id (mode 6).

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

<a name="recommissionAreaApiV1AreasAreaIdRecommissionPost"></a>
# **recommissionAreaApiV1AreasAreaIdRecommissionPost**
> oas_any_type_not_mapped recommissionAreaApiV1AreasAreaIdRecommissionPost(area\_id, AreaActionRequest)

Recommission area

    Recommission a decommissioned area back to active (mode 8).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **area\_id** | **Integer**|  | [default to null] |
| **AreaActionRequest** | [**AreaActionRequest**](../Models/AreaActionRequest.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="updateAreaApiV1AreasAreaIdPut"></a>
# **updateAreaApiV1AreasAreaIdPut**
> oas_any_type_not_mapped updateAreaApiV1AreasAreaIdPut(area\_id, AreaUpdate)

Update area

    Update an existing area (mode 4). Only fields provided are updated — omitted fields keep current DB value.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **area\_id** | **Integer**|  | [default to null] |
| **AreaUpdate** | [**AreaUpdate**](../Models/AreaUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

