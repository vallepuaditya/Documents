# ScheduleOverrideEntry
## Properties

| Name | Type | Description | Notes |
|------------ | ------------- | ------------- | -------------|
| **override\_date** | **date** | Override date (YYYY-MM-DD) | [default to null] |
| **open\_time** | **String** | Opening time (HH:mm); required when is_closed is false | [optional] [default to null] |
| **close\_time** | **String** | Closing time (HH:mm); required when is_closed is false | [optional] [default to null] |
| **is\_closed** | **Boolean** | When true, open_time and close_time may be null | [default to null] |

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

