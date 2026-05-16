# ResourceTypesApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**deactivateResourceTypeApiV1ResourceTypesResourceTypeIdDelete**](ResourceTypesApi.md#deactivateResourceTypeApiV1ResourceTypesResourceTypeIdDelete) | **DELETE** /api/v1/resource-types/{resource_type_id} | Deactivate resource type (mode 5) |
| [**getAvailableLookupApiV1ResourceTypesAvailableLookupGet**](ResourceTypesApi.md#getAvailableLookupApiV1ResourceTypesAvailableLookupGet) | **GET** /api/v1/resource-types/available-lookup | DEPRECATED — use /by-category-dropdown (mode 6) |
| [**getResourceTypeApiV1ResourceTypesResourceTypeIdGet**](ResourceTypesApi.md#getResourceTypeApiV1ResourceTypesResourceTypeIdGet) | **GET** /api/v1/resource-types/{resource_type_id} | Get resource type by id (mode 2) |
| [**listLinkableCategoriesApiV1ResourceTypesLinkableCategoriesGet**](ResourceTypesApi.md#listLinkableCategoriesApiV1ResourceTypesLinkableCategoriesGet) | **GET** /api/v1/resource-types/linkable-categories | List categories available for linking (mode 9) |
| [**listResourceCategoriesApiV1ResourceTypesCategoriesGet**](ResourceTypesApi.md#listResourceCategoriesApiV1ResourceTypesCategoriesGet) | **GET** /api/v1/resource-types/categories | List active resource categories (mode 7) |
| [**listResourceTypesApiV1ResourceTypesGet**](ResourceTypesApi.md#listResourceTypesApiV1ResourceTypesGet) | **GET** /api/v1/resource-types/ | List active resource types (mode 1) |
| [**listResourceTypesByCategoryApiV1ResourceTypesByCategoryGet**](ResourceTypesApi.md#listResourceTypesByCategoryApiV1ResourceTypesByCategoryGet) | **GET** /api/v1/resource-types/by-category | List resource types in a category (mode 8) |
| [**listResourceTypesByCategoryDropdownApiV1ResourceTypesByCategoryDropdownGet**](ResourceTypesApi.md#listResourceTypesByCategoryDropdownApiV1ResourceTypesByCategoryDropdownGet) | **GET** /api/v1/resource-types/by-category-dropdown | List active resource types for category dropdown (mode 6) |
| [**resourceTypesOperationApiV1ResourceTypesPost**](ResourceTypesApi.md#resourceTypesOperationApiV1ResourceTypesPost) | **POST** /api/v1/resource-types/ | Resource types — all operations (p_mode in JSON body) |
| [**updateResourceTypeApiV1ResourceTypesResourceTypeIdPut**](ResourceTypesApi.md#updateResourceTypeApiV1ResourceTypesResourceTypeIdPut) | **PUT** /api/v1/resource-types/{resource_type_id} | Update resource type (mode 4) |


<a name="deactivateResourceTypeApiV1ResourceTypesResourceTypeIdDelete"></a>
# **deactivateResourceTypeApiV1ResourceTypesResourceTypeIdDelete**
> oas_any_type_not_mapped deactivateResourceTypeApiV1ResourceTypesResourceTypeIdDelete(resource\_type\_id)

Deactivate resource type (mode 5)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_type\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getAvailableLookupApiV1ResourceTypesAvailableLookupGet"></a>
# **getAvailableLookupApiV1ResourceTypesAvailableLookupGet**
> oas_any_type_not_mapped getAvailableLookupApiV1ResourceTypesAvailableLookupGet(category\_id)

DEPRECATED — use /by-category-dropdown (mode 6)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **category\_id** | **Integer**|  | [optional] [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getResourceTypeApiV1ResourceTypesResourceTypeIdGet"></a>
# **getResourceTypeApiV1ResourceTypesResourceTypeIdGet**
> oas_any_type_not_mapped getResourceTypeApiV1ResourceTypesResourceTypeIdGet(resource\_type\_id)

Get resource type by id (mode 2)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_type\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listLinkableCategoriesApiV1ResourceTypesLinkableCategoriesGet"></a>
# **listLinkableCategoriesApiV1ResourceTypesLinkableCategoriesGet**
> List listLinkableCategoriesApiV1ResourceTypesLinkableCategoriesGet(exclude\_category\_id)

List categories available for linking (mode 9)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **exclude\_category\_id** | **Integer**|  | [optional] [default to null] |

### Return type

[**List**](../Models/LinkableCategoryResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listResourceCategoriesApiV1ResourceTypesCategoriesGet"></a>
# **listResourceCategoriesApiV1ResourceTypesCategoriesGet**
> List listResourceCategoriesApiV1ResourceTypesCategoriesGet()

List active resource categories (mode 7)

### Parameters
This endpoint does not need any parameter.

### Return type

[**List**](../Models/app__schemas__resources__CategoryResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listResourceTypesApiV1ResourceTypesGet"></a>
# **listResourceTypesApiV1ResourceTypesGet**
> oas_any_type_not_mapped listResourceTypesApiV1ResourceTypesGet()

List active resource types (mode 1)

### Parameters
This endpoint does not need any parameter.

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listResourceTypesByCategoryApiV1ResourceTypesByCategoryGet"></a>
# **listResourceTypesByCategoryApiV1ResourceTypesByCategoryGet**
> List listResourceTypesByCategoryApiV1ResourceTypesByCategoryGet(category\_id)

List resource types in a category (mode 8)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **category\_id** | **Integer**|  | [optional] [default to null] |

### Return type

[**List**](../Models/ResourceTypeInCategoryResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listResourceTypesByCategoryDropdownApiV1ResourceTypesByCategoryDropdownGet"></a>
# **listResourceTypesByCategoryDropdownApiV1ResourceTypesByCategoryDropdownGet**
> oas_any_type_not_mapped listResourceTypesByCategoryDropdownApiV1ResourceTypesByCategoryDropdownGet(category\_id)

List active resource types for category dropdown (mode 6)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **category\_id** | **Integer**|  | [optional] [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="resourceTypesOperationApiV1ResourceTypesPost"></a>
# **resourceTypesOperationApiV1ResourceTypesPost**
> oas_any_type_not_mapped resourceTypesOperationApiV1ResourceTypesPost(ResourceTypesPayload)

Resource types — all operations (p_mode in JSON body)

    Modes: 1&#x3D;list, 2&#x3D;get by id, 3&#x3D;create, 4&#x3D;update, 5&#x3D;deactivate, 6&#x3D;types dropdown, 7-9&#x3D;category helpers. Success: JSON array (modes 1-9 per fn_resource_types). Create (mode 3): HTTP 201. Errors: HTTP 400/500 with &#x60;{ \&quot;error\&quot;: \&quot;&lt;CODE&gt;\&quot;, \&quot;message\&quot;: \&quot;&lt;text&gt;\&quot; }&#x60;.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **ResourceTypesPayload** | [**ResourceTypesPayload**](../Models/ResourceTypesPayload.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="updateResourceTypeApiV1ResourceTypesResourceTypeIdPut"></a>
# **updateResourceTypeApiV1ResourceTypesResourceTypeIdPut**
> oas_any_type_not_mapped updateResourceTypeApiV1ResourceTypesResourceTypeIdPut(resource\_type\_id, ResourceTypeUpdate)

Update resource type (mode 4)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_type\_id** | **Integer**|  | [default to null] |
| **ResourceTypeUpdate** | [**ResourceTypeUpdate**](../Models/ResourceTypeUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

