# UserTiersApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createUserTierApiV1UserTiersPost**](UserTiersApi.md#createUserTierApiV1UserTiersPost) | **POST** /api/v1/user-tiers/ | Create User Tier |
| [**deactivateUserTierApiV1UserTiersUserTierIdDelete**](UserTiersApi.md#deactivateUserTierApiV1UserTiersUserTierIdDelete) | **DELETE** /api/v1/user-tiers/{user_tier_id} | Deactivate User Tier |
| [**getUserTierApiV1UserTiersUserTierIdGet**](UserTiersApi.md#getUserTierApiV1UserTiersUserTierIdGet) | **GET** /api/v1/user-tiers/{user_tier_id} | Get User Tier |
| [**listUserTiersApiV1UserTiersGet**](UserTiersApi.md#listUserTiersApiV1UserTiersGet) | **GET** /api/v1/user-tiers/ | List User Tiers |
| [**updateUserTierApiV1UserTiersUserTierIdPut**](UserTiersApi.md#updateUserTierApiV1UserTiersUserTierIdPut) | **PUT** /api/v1/user-tiers/{user_tier_id} | Update User Tier |


<a name="createUserTierApiV1UserTiersPost"></a>
# **createUserTierApiV1UserTiersPost**
> oas_any_type_not_mapped createUserTierApiV1UserTiersPost(UserTierCreate)

Create User Tier

    Create tier (fn_user_tiers mode 3).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **UserTierCreate** | [**UserTierCreate**](../Models/UserTierCreate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deactivateUserTierApiV1UserTiersUserTierIdDelete"></a>
# **deactivateUserTierApiV1UserTiersUserTierIdDelete**
> oas_any_type_not_mapped deactivateUserTierApiV1UserTiersUserTierIdDelete(user\_tier\_id)

Deactivate User Tier

    Deactivate tier (fn_user_tiers mode 5).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_tier\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="getUserTierApiV1UserTiersUserTierIdGet"></a>
# **getUserTierApiV1UserTiersUserTierIdGet**
> oas_any_type_not_mapped getUserTierApiV1UserTiersUserTierIdGet(user\_tier\_id)

Get User Tier

    Get tier by id (fn_user_tiers mode 2).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_tier\_id** | **Integer**|  | [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="listUserTiersApiV1UserTiersGet"></a>
# **listUserTiersApiV1UserTiersGet**
> oas_any_type_not_mapped listUserTiersApiV1UserTiersGet(location\_id)

List User Tiers

    List all active tiers (fn_user_tiers mode 1).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **location\_id** | **Integer**| Filter by location ID | [optional] [default to null] |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="updateUserTierApiV1UserTiersUserTierIdPut"></a>
# **updateUserTierApiV1UserTiersUserTierIdPut**
> oas_any_type_not_mapped updateUserTierApiV1UserTiersUserTierIdPut(user\_tier\_id, UserTierUpdate)

Update User Tier

    Update tier (fn_user_tiers mode 4).

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **user\_tier\_id** | **Integer**|  | [default to null] |
| **UserTierUpdate** | [**UserTierUpdate**](../Models/UserTierUpdate.md)|  | |

### Return type

[**oas_any_type_not_mapped**](../Models/AnyType.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

