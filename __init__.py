import logging

import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    input_string = req.params.get('input_string')
    if not input_string:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            input_string = req_body.get('input_string')

    if input_string:
        d = {
            "Oracle": "Oracle©",
            "Google": "Google©",
            "Microsoft": "Microsoft©",
            "Amazon": "Amazon©",
            "Deloitte": "Deloitte©"            
        }
        
        for k in d.keys():
            if k in input_string:
                input_string = input_string.replace(k, d[k])
            
        return func.HttpResponse(f"{input_string}")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a input_string in the query string or in the request body for a personalized response.",
             status_code=200
        )

