DECLARE @EndpointUrl NVARCHAR(500) = 'https://example.com/api/invoice-stock'; -- Replace with your actual endpoint URL
DECLARE @Payload NVARCHAR(MAX);
DECLARE @Object INT;
DECLARE @ResponseText NVARCHAR(MAX);

-- Construct your invoice and stock movement JSON payload
SET @Payload = '
{
    "invoices": [
            {
                        "invoiceNumber": "INV001",
                                    "invoiceDate": "2024-06-25",
                                                "customerName": "Customer A",
                                                            "amount": 100.00
                                                                    },
                                                                            {
                                                                                        "invoiceNumber": "INV002",
                                                                                                    "invoiceDate": "2024-06-25",
                                                                                                                "customerName": "Customer B",
                                                                                                                            "amount": 150.00
                                                                                                                                    }
                                                                                                                                        ],
                                                                                                                                            "stockMovements": [
                                                                                                                                                    {
                                                                                                                                                                "productCode": "P001",
                                                                                                                                                                            "quantity": 10,
                                                                                                                                                                                        "movementType": "IN"
                                                                                                                                                                                                },
                                                                                                                                                                                                        {
                                                                                                                                                                                                                    "productCode": "P002",
                                                                                                                                                                                                                                "quantity": 5,
                                                                                                                                                                                                                                            "movementType": "OUT"
                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                        ]
                                                                                                                                                                                                                                                        }';

                                                                                                                                                                                                                                                        -- Bearer token received from endpoint login
                                                                                                                                                                                                                                                        DECLARE @Token NVARCHAR(500) = 'your_bearer_token_here';

                                                                                                                                                                                                                                                        -- Create the HTTP request object
                                                                                                                                                                                                                                                        EXEC sp_OACreate 'MSXML2.ServerXMLHTTP', @Object OUT;

                                                                                                                                                                                                                                                        -- Open the HTTP connection
                                                                                                                                                                                                                                                        EXEC sp_OAMethod @Object, 'open', NULL, 'POST', @EndpointUrl, 'false';

                                                                                                                                                                                                                                                        -- Set the request headers
                                                                                                                                                                                                                                                        EXEC sp_OAMethod @Object, 'setRequestHeader', NULL, 'Content-Type', 'application/json';
                                                                                                                                                                                                                                                        EXEC sp_OAMethod @Object, 'setRequestHeader', NULL, 'Authorization', 'Bearer ' + @Token;

                                                                                                                                                                                                                                                        -- Send the request with payload
                                                                                                                                                                                                                                                        EXEC sp_OAMethod @Object, 'send', NULL, @Payload;

                                                                                                                                                                                                                                                        -- Receive the response
                                                                                                                                                                                                                                                        EXEC sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT;

                                                                                                                                                                                                                                                        -- Close the HTTP connection
                                                                                                                                                                                                                                                        EXEC sp_OADestroy @Object;

                                                                                                                                                                                                                                                        -- Display the response from the server (optional)
                                                                                                                                                                                                                                                        SELECT @ResponseText AS ResponseText;