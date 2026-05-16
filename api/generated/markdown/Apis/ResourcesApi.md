# ResourcesApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**availableToLinkApiV1ResourcesAvailableToLinkGet**](ResourcesApi.md#availableToLinkApiV1ResourcesAvailableToLinkGet) | **GET** /api/v1/resources/available-to-link | Available To Link |
| [**createResourceApiV1ResourcesPost**](ResourcesApi.md#createResourceApiV1ResourcesPost) | **POST** /api/v1/resources/ | Create Resource |
| [**createResourceLinkExistingApiV1ResourcesLinkExistingPost**](ResourcesApi.md#createResourceLinkExistingApiV1ResourcesLinkExistingPost) | **POST** /api/v1/resources/link-existing | Create Resource Link Existing |
| [**createResourceLinkNewApiV1ResourcesLinkNewPost**](ResourcesApi.md#createResourceLinkNewApiV1ResourcesLinkNewPost) | **POST** /api/v1/resources/link-new | Create Resource Link New |
| [**decommissionResourceApiV1ResourcesResourceIdDecommissionPost**](ResourcesApi.md#decommissionResourceApiV1ResourcesResourceIdDecommissionPost) | **POST** /api/v1/resources/{resource_id}/decommission | Decommission Resource |
| [**getResourceApiV1ResourcesResourceIdGet**](ResourcesApi.md#getResourceApiV1ResourcesResourceIdGet) | **GET** /api/v1/resources/{resource_id} | Get Resource |
| [**listLinkableResourcesApiV1ResourcesLinkableGet**](ResourcesApi.md#listLinkableResourcesApiV1ResourcesLinkableGet) | **GET** /api/v1/resources/linkable | List resources available for category linking (mode 12) |
| [**listResourcesApiV1ResourcesGet**](ResourcesApi.md#listResourcesApiV1ResourcesGet) | **GET** /api/v1/resources/ | List Resources |
| [**resourcesByAreaApiV1ResourcesByAreaAreaIdGet**](ResourcesApi.md#resourcesByAreaApiV1ResourcesByAreaAreaIdGet) | **GET** /api/v1/resources/by-area/{area_id} | Resources By Area |
| [**typeCardCountsApiV1ResourcesTypeCardCountsGet**](ResourcesApi.md#typeCardCountsApiV1ResourcesTypeCardCountsGet) | **GET** /api/v1/resources/type-card-counts | Type Card Counts |
| [**unlinkResourceApiV1ResourcesResourceIdUnlinkPost**](ResourcesApi.md#unlinkResourceApiV1ResourcesResourceIdUnlinkPost) | **POST** /api/v1/resources/{resource_id}/unlink | Unlink Resource |
| [**updateResourceApiV1ResourcesResourceIdPut**](ResourcesApi.md#updateResourceApiV1ResourcesResourceIdPut) | **PUT** /api/v1/resources/{resource_id} | Update Resource |
| [**updateResourceStatusApiV1ResourcesResourceIdStatusPost**](ResourcesApi.md#updateResourceStatusApiV1ResourcesResourceIdStatusPost) | **POST** /api/v1/resources/{resource_id}/status | Update Resource Status |


<a name="availableToLinkApiV1ResourcesAvailableToLinkGet"></a>
# **availableToLinkApiV1ResourcesAvailableToLinkGet**
> oas_any_type_not_mapped availableToLinkApiV1ResourcesAvailableToLinkGet(area\_id, exclude\_category\_id, filter\_type\_id)

Available To Link

    Resources available to link (mode 9).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **area\_id** | **Integer**| Area to search within | [default to null] |
| **exclude\_category\_id** | **Integer**|  | [optional] [default to null] |
| **filter\_type\_id** | **Integer**|  | [optional] [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="createResourceApiV1ResourcesPost"></a>
# **createResourceApiV1ResourcesPost**
> oas_any_type_not_mapped createResourceApiV1ResourcesPost(ResourceCreate)

Create Resource

    Create standalone resource (mode 3).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **ResourceCreate** | [**ResourceCreate**](../Models/ResourceCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="createResourceLinkExistingApiV1ResourcesLinkExistingPost"></a>
# **createResourceLinkExistingApiV1ResourcesLinkExistingPost**
> oas_any_type_not_mapped createResourceLinkExistingApiV1ResourcesLinkExistingPost(ResourceCreateLinkedExisting)

Create Resource Link Existing

    Create resource linked to existing (mode 4).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **ResourceCreateLinkedExisting** | [**ResourceCreateLinkedExisting**](../Models/ResourceCreateLinkedExisting.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="createResourceLinkNewApiV1ResourcesLinkNewPost"></a>
# **createResourceLinkNewApiV1ResourcesLinkNewPost**
> oas_any_type_not_mapped createResourceLinkNewApiV1ResourcesLinkNewPost(ResourceCreateLinkedNew)

Create Resource Link New

    Create resource with new linked resource (mode 5).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **ResourceCreateLinkedNew** | [**ResourceCreateLinkedNew**](../Models/ResourceCreateLinkedNew.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="decommissionResourceApiV1ResourcesResourceIdDecommissionPost"></a>
# **decommissionResourceApiV1ResourcesResourceIdDecommissionPost**
> oas_any_type_not_mapped decommissionResourceApiV1ResourcesResourceIdDecommissionPost(resource\_id, ResourceDecommission)

Decommission Resource

    Decommission resource (mode 11).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_id** | **Integer**|  | [default to null] |
| **ResourceDecommission** | [**ResourceDecommission**](../Models/ResourceDecommission.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="getResourceApiV1ResourcesResourceIdGet"></a>
# **getResourceApiV1ResourcesResourceIdGet**
> oas_any_type_not_mapped getResourceApiV1ResourcesResourceIdGet(resource\_id)

Get Resource

    Get resource by id (mode 2).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listLinkableResourcesApiV1ResourcesLinkableGet"></a>
# **listLinkableResourcesApiV1ResourcesLinkableGet**
> List listLinkableResourcesApiV1ResourcesLinkableGet(area\_id, exclude\_category\_id)

List resources available for category linking (mode 12)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **area\_id** | **Integer**|  | [optional] [default to null] |
| **exclude\_category\_id** | **Integer**|  | [optional] [default to null] |

### Return type

[**List**](../Models/LinkableResourceResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listResourcesApiV1ResourcesGet"></a>
# **listResourcesApiV1ResourcesGet**
> oas_any_type_not_mapped listResourcesApiV1ResourcesGet()

List Resources

    List resources (mode 1).

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="resourcesByAreaApiV1ResourcesByAreaAreaIdGet"></a>
# **resourcesByAreaApiV1ResourcesByAreaAreaIdGet**
> oas_any_type_not_mapped resourcesByAreaApiV1ResourcesByAreaAreaIdGet(area\_id)

Resources By Area

    Resources in an area (mode 8).

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

<a name="typeCardCountsApiV1ResourcesTypeCardCountsGet"></a>
# **typeCardCountsApiV1ResourcesTypeCardCountsGet**
> oas_any_type_not_mapped typeCardCountsApiV1ResourcesTypeCardCountsGet()

Type Card Counts

    Per-type card counts (mode 10).

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="unlinkResourceApiV1ResourcesResourceIdUnlinkPost"></a>
# **unlinkResourceApiV1ResourcesResourceIdUnlinkPost**
> oas_any_type_not_mapped unlinkResourceApiV1ResourcesResourceIdUnlinkPost(resource\_id, ResourceUnlink)

Unlink Resource

    Unlink two linked resources (mode 13).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_id** | **Integer**|  | [default to null] |
| **ResourceUnlink** | [**ResourceUnlink**](../Models/ResourceUnlink.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="updateResourceApiV1ResourcesResourceIdPut"></a>
# **updateResourceApiV1ResourcesResourceIdPut**
> oas_any_type_not_mapped updateResourceApiV1ResourcesResourceIdPut(resource\_id, ResourceUpdate)

Update Resource

    Update resource (mode 6).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_id** | **Integer**|  | [default to null] |
| **ResourceUpdate** | [**ResourceUpdate**](../Models/ResourceUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="updateResourceStatusApiV1ResourcesResourceIdStatusPost"></a>
# **updateResourceStatusApiV1ResourcesResourceIdStatusPost**
> oas_any_type_not_mapped updateResourceStatusApiV1ResourcesResourceIdStatusPost(resource\_id, ResourceStatusUpdate)

Update Resource Status

    Update resource status (mode 7).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_id** | **Integer**|  | [default to null] |
| **ResourceStatusUpdate** | [**ResourceStatusUpdate**](../Models/ResourceStatusUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

