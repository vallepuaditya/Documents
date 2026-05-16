# ResourceCategoriesApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createCategoryApiV1ResourceCategoriesPost**](ResourceCategoriesApi.md#createCategoryApiV1ResourceCategoriesPost) | **POST** /api/v1/resource-categories/ | Create Category |
| [**deactivateCategoryApiV1ResourceCategoriesCategoryIdDeactivatePost**](ResourceCategoriesApi.md#deactivateCategoryApiV1ResourceCategoriesCategoryIdDeactivatePost) | **POST** /api/v1/resource-categories/{category_id}/deactivate | Deactivate Category |
| [**getCategoryApiV1ResourceCategoriesCategoryIdGet**](ResourceCategoriesApi.md#getCategoryApiV1ResourceCategoriesCategoryIdGet) | **GET** /api/v1/resource-categories/{category_id} | Get Category |
| [**listCategoriesApiV1ResourceCategoriesGet**](ResourceCategoriesApi.md#listCategoriesApiV1ResourceCategoriesGet) | **GET** /api/v1/resource-categories/ | List Categories |
| [**updateCategoryApiV1ResourceCategoriesCategoryIdPut**](ResourceCategoriesApi.md#updateCategoryApiV1ResourceCategoriesCategoryIdPut) | **PUT** /api/v1/resource-categories/{category_id} | Update Category |


<a name="createCategoryApiV1ResourceCategoriesPost"></a>
# **createCategoryApiV1ResourceCategoriesPost**
> oas_any_type_not_mapped createCategoryApiV1ResourceCategoriesPost(CategoryCreate)

Create Category

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **CategoryCreate** | [**CategoryCreate**](../Models/CategoryCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deactivateCategoryApiV1ResourceCategoriesCategoryIdDeactivatePost"></a>
# **deactivateCategoryApiV1ResourceCategoriesCategoryIdDeactivatePost**
> oas_any_type_not_mapped deactivateCategoryApiV1ResourceCategoriesCategoryIdDeactivatePost(category\_id, CategoryDeactivate)

Deactivate Category

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **category\_id** | **Integer**|  | [default to null] |
| **CategoryDeactivate** | [**CategoryDeactivate**](../Models/CategoryDeactivate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="getCategoryApiV1ResourceCategoriesCategoryIdGet"></a>
# **getCategoryApiV1ResourceCategoriesCategoryIdGet**
> List getCategoryApiV1ResourceCategoriesCategoryIdGet(category\_id)

Get Category

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **category\_id** | **Integer**|  | [default to null] |

### Return type

[**List**](../Models/app__schemas__resource_categories__CategoryResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listCategoriesApiV1ResourceCategoriesGet"></a>
# **listCategoriesApiV1ResourceCategoriesGet**
> List listCategoriesApiV1ResourceCategoriesGet()

List Categories

### Parameters
This endpoint does not need any parameter.

### Return type

[**List**](../Models/app__schemas__resource_categories__CategoryResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateCategoryApiV1ResourceCategoriesCategoryIdPut"></a>
# **updateCategoryApiV1ResourceCategoriesCategoryIdPut**
> oas_any_type_not_mapped updateCategoryApiV1ResourceCategoriesCategoryIdPut(category\_id, CategoryUpdate)

Update Category

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **category\_id** | **Integer**|  | [default to null] |
| **CategoryUpdate** | [**CategoryUpdate**](../Models/CategoryUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

