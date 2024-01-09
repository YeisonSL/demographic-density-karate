Feature: Validate the correct functioning of the Demographic Density API
  Me as a user of the Demographic Density API
  I wish we can consult consuming the API
  To know the countries with the highest demographic density

  Background: :URL settings
    * url "http://localhost:8000"
    * headers "Content-Type = application/json"

  @DensidadDemografica_Validate_Size
  Scenario Outline: : Obtain the 5 countries with the highest demographic density
    Given path '/densidad-demografica'
    When method get
    Then status 200
    Then print 'size is : ',  response.length
    And assert response.length == <size>

    Examples:
      | size |
      | 5    |
      | 10   |
      | 0    |
      |      |


  @DensidadDemografica_Validate_Status
  Scenario Outline: Validate Response Status
    Given path '/densidad-demografica'
    When method get
    Then status <status>

    Examples:
      | status |
      | 200    |
      | 201    |
      | 401    |

  @Happy_DensidadDemografica_Validate_Fiels
  Scenario: Validate Empty Fields
    Given path '/densidad-demografica'
    When method get
    Then match response == '#notnull'
    And match each response.[*].name == '#notnull'
    And match each response.[*].area == '#notnull'
    And match each response.[*].population == '#notnull'
    And match each response.[*].populationDensity == '#notnull'

  @Happy_DensidadDemografica_Validate_Fiels_Failed
  Scenario: Validate Empty Fields Failed
    Given path '/densidad-demografica'
    When method get
    Then match response == '#notnull'
    And match each response.[*].name == '#null'
    And match each response.[*].area == '#null'
    And match each response.[*].population == '#null'
    And match each response.[*].populationDensity == 'null'


  @DensidadDemografica_Validate_Response
  Scenario: Validate Info Response
    * def jsonResponse = read('../json/countriesResponse.json')
    Given path '/densidad-demografica'
    When method get
    Then match response == jsonResponse

  @DensidadDemografica_Validate_Response_Failed
  Scenario: Validate Info Response Failed
    * def jsonResponseFailed = read('../json/countrieResponseFailed.json')
    Given path '/densidad-demografica'
    When method get
    Then match response != jsonResponseFailed
