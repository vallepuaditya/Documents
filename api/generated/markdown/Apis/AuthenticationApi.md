# AuthenticationApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**loginRouteApiV1AuthLoginPost**](AuthenticationApi.md#loginRouteApiV1AuthLoginPost) | **POST** /api/v1/auth/login | Login Route |
| [**logoutRouteApiV1AuthLogoutPost**](AuthenticationApi.md#logoutRouteApiV1AuthLogoutPost) | **POST** /api/v1/auth/logout | Logout Route |
| [**refreshRouteApiV1AuthRefreshTokenPost**](AuthenticationApi.md#refreshRouteApiV1AuthRefreshTokenPost) | **POST** /api/v1/auth/refresh-token | Refresh Route |
| [**verifyRouteApiV1AuthVerifyTokenGet**](AuthenticationApi.md#verifyRouteApiV1AuthVerifyTokenGet) | **GET** /api/v1/auth/verify-token | Verify Route |


<a name="loginRouteApiV1AuthLoginPost"></a>
# **loginRouteApiV1AuthLoginPost**
> LoginResponse loginRouteApiV1AuthLoginPost(LoginRequest)

Login Route

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **LoginRequest** | [**LoginRequest**](../Models/LoginRequest.md)|  | |

### Return type

[**LoginResponse**](../Models/LoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="logoutRouteApiV1AuthLogoutPost"></a>
# **logoutRouteApiV1AuthLogoutPost**
> LogoutResponse logoutRouteApiV1AuthLogoutPost(RefreshTokenRequest)

Logout Route

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **RefreshTokenRequest** | [**RefreshTokenRequest**](../Models/RefreshTokenRequest.md)|  | |

### Return type

[**LogoutResponse**](../Models/LogoutResponse.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="refreshRouteApiV1AuthRefreshTokenPost"></a>
# **refreshRouteApiV1AuthRefreshTokenPost**
> RefreshTokenResponse refreshRouteApiV1AuthRefreshTokenPost(RefreshTokenRequest)

Refresh Route

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **RefreshTokenRequest** | [**RefreshTokenRequest**](../Models/RefreshTokenRequest.md)|  | |

### Return type

[**RefreshTokenResponse**](../Models/RefreshTokenResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="verifyRouteApiV1AuthVerifyTokenGet"></a>
# **verifyRouteApiV1AuthVerifyTokenGet**
> VerifyTokenResponse verifyRouteApiV1AuthVerifyTokenGet()

Verify Route

### Parameters
This endpoint does not need any parameter.

### Return type

[**VerifyTokenResponse**](../Models/VerifyTokenResponse.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

