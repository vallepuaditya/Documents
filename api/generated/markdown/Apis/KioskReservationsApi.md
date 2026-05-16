# KioskReservationsApi

All URIs are relative to */tracsystems_api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**kioskCreateReservationApiV1KioskReservationsPost**](KioskReservationsApi.md#kioskCreateReservationApiV1KioskReservationsPost) | **POST** /api/v1/kiosk/reservations | Create reservation from kiosk (fn_kiosk_create_reservation) |
| [**kioskResourcesAvailabilityApiV1KioskResourcesAvailabilityGet**](KioskReservationsApi.md#kioskResourcesAvailabilityApiV1KioskResourcesAvailabilityGet) | **GET** /api/v1/kiosk/resources/availability | Slot-aware resource list for reservations |


<a name="kioskCreateReservationApiV1KioskReservationsPost"></a>
# **kioskCreateReservationApiV1KioskReservationsPost**
> CreateReservationEnvelope kioskCreateReservationApiV1KioskReservationsPost(CreateReservationRequest)

Create reservation from kiosk (fn_kiosk_create_reservation)

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **CreateReservationRequest** | [**CreateReservationRequest**](../Models/CreateReservationRequest.md)|  | |

### Return type

[**CreateReservationEnvelope**](../Models/CreateReservationEnvelope.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="kioskResourcesAvailabilityApiV1KioskResourcesAvailabilityGet"></a>
# **kioskResourcesAvailabilityApiV1KioskResourcesAvailabilityGet**
> KioskAvailabilityEnvelope kioskResourcesAvailabilityApiV1KioskResourcesAvailabilityGet(resource\_type\_id, location\_id, reservation\_date, start\_time, booking\_mode)

Slot-aware resource list for reservations

    **Primary kiosk API for the booking grid.** Call &#x60;GET /api/v1/kiosk/resources/availability&#x60; (instead of legacy &#x60;GET /api/v1/kiosk/resources&#x60;) whenever the user is picking a slot or resource for a reservation.  **When to call this endpoint**  - After the user chooses a **resource type** (first paint of the booking list): use the   selected type with **current local date and time** (or your product default slot). - Again whenever **reservation_date** changes. - Again whenever **start_time** changes. - Again whenever **booking_mode** changes (&#x60;instant&#x60;, &#x60;scheduled&#x60;, or &#x60;specific&#x60;).  **Response contract**  - Returns **every** resource row produced by &#x60;fn_kiosk_resources_availability&#x60; for the type   and location (slot overlap, linked resource, &#x60;availability_status&#x60;, &#x60;display_status&#x60;,   &#x60;is_selectable&#x60;, and &#x60;reserved_reason&#x60; come from the database; do not drop rows in the   API layer). - Repeated slot fields (&#x60;booking_mode&#x60;, &#x60;reservation_date&#x60;, &#x60;start_time&#x60;, &#x60;duration_minutes&#x60;,   &#x60;slot_start&#x60;, &#x60;slot_end&#x60;) are returned once in **&#x60;slot_context&#x60;**, not on each &#x60;data&#x60; item. - &#x60;display_status&#x60; is intended for UI coloring only, using DB values as-is (commonly   &#x60;available&#x60;, &#x60;reserved&#x60;, &#x60;offline&#x60;, &#x60;maintenance&#x60;).  &#x60;location_id&#x60; must match the location on the kiosk JWT.

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **resource\_type\_id** | **Integer**| Resource type the user selected on the booking flow. | [default to null] |
| **location\_id** | **Integer**| Must equal &#x60;location_id&#x60; on the kiosk access token. | [default to null] |
| **reservation\_date** | **date**| Calendar date for the reservation slot. | [default to null] |
| **start\_time** | **String**| Slot start time (local); re-fetch whenever this changes. | [default to null] |
| **booking\_mode** | **String**| One of: instant | scheduled | specific (normalized with strip/lower). Re-fetch when this changes. | [optional] [default to instant] |

### Return type

[**KioskAvailabilityEnvelope**](../Models/KioskAvailabilityEnvelope.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

