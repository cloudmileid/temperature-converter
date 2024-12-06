# temperature-converter

Cloud function terraform temperature-converter example

## How to deploy this demo

## How to test this demo

- Sign in to the Google Cloud console, and open the Cloud Shell terminal window.
- Run the following commands in Cloud Shell to set your Project ID and Region environment variables:

    ```bash
    PROJECT_ID=$(gcloud config get-value project)
    REGION=us-central1
    ```

- In Cloud Shell, retrieve the HTTP URI of the function and store it in an environment variable:

    ```bash
    FUNCTION_URI=$(gcloud functions describe temperature-converter --gen2 --region $REGION --format "value(serviceConfig.uri)"); echo $FUNCTION_URI
    ```

- In Cloud Shell, test the function with the following command:

    ```bash
    curl -H "Authorization: bearer $(gcloud auth print-identity-token)" "${FUNCTION_URI}?temp=70"
    ```

- Rerun the command passing in the temperature value in Celsius and the conversion unit:

    ```bash
    curl -H "Authorization: bearer $(gcloud auth print-identity-token)" "${FUNCTION_URI}?temp=21.11&convert=ctof"
    ```

- If `TEMP_CONVERT_TO` defined in the environment variable, run:

    ```bash
    curl -H "Authorization: bearer $(gcloud auth print-identity-token)" "${FUNCTION_URI}?temp=21.11"
    ```
