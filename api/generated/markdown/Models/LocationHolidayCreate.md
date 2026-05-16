# LocationHolidayCreate
## Properties

| Name | Type | Description | Notes |
|------------ | ------------- | ------------- | -------------|
| **location\_id** | **Integer** | Location surrogate key (required) | [default to null] |
| **holiday\_name** | **String** | Name of the holiday (required) | [default to null] |
| **start\_date** | **date** | Holiday start date (required) | [default to null] |
| **end\_date** | **date** | Holiday end date (required) | [default to null] |
| **closure\_type** | [**ClosureType**](ClosureType.md) | Closure type | [optional] [default to null] |
| **is\_active** | **Boolean** | Whether the holiday is active (defaults to True) | [optional] [default to null] |
| **created\_by** | **Integer** | User who created the record | [optional] [default to null] |
| **updated\_by** | **Integer** | User who updated the record | [optional] [default to null] |

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

