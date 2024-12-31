import sys
import os
from azure.communication.email import EmailClient

def main():
    try:
        KVName = sys.argv[1]
        SecretName = sys.argv[2]
        WorkspaceURL = sys.argv[3]
        RecipientEmail = sys.argv[4]
        SenderEmail = sys.argv[5]

        connection_string = os.environ.get('CONNECTION_STRING')
        build_id = os.environ.get('BUILD_ID')

        client = EmailClient.from_connection_string(connection_string)

        message = {
            "senderAddress": f"{SenderEmail}",
            "recipients": {
                "to": [{"address": f"{RecipientEmail}"}]
            },
            "content": {
                "subject": "Azure DevOps - Databricks PAT Generated",
                "plainText": f"Secret URL",
                "html": f"""
				<html>
                    <body>
                        <p>Dear User,</p>
                        <p>A Key Vault secret has been successfully created/updated following your recent pipeline execution with the Personal Access Token for the Databricks workspace {WorkspaceURL}. </p>
                        <p>You can access the secret by clicking <a href='https://portal.azure.com/#<UPDATE-WITH-YOUR-TENANT-NAME-HERE>.onmicrosoft.com/asset/Microsoft_Azure_KeyVault/Secret/https://{KVName}.vault.azure.net/secrets/{SecretName}'>here</a>.</p>
                        <p>Regards,<br>Azure DevOps Pipeline <br> (Build ID: {build_id})</p>
                    </body>
                    </html>"""
            },
        }

        poller = client.begin_send(message)
        print("Message sent")

    except Exception as ex:
        print("ERROR: \n",ex)

main()
