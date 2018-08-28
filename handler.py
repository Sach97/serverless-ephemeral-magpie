'''
This is needed so that the script running on AWS will pick up the pre-compiled dependencies
from the vendored folder
'''
import sys
sys.path.insert(0, './text-classification')

import logging
logger = logging.getLogger()
if logger.handlers:
    for handler in logger.handlers:
        logger.removeHandler(handler)
logging.basicConfig(level=logging.INFO)

from magpie_model import MagpieModel
import numpy as np
import utils
import os


# '''
# Declare global objects living across requests
# '''
model_dir = utils.create_model_dir()
utils.download_model_from_bucket(model_dir)
#currentdir = os.path.join(os.getcwd()) # uncomment this for simulating local lambda invoke
#model_dir = currentdir+ '/model' #  uncomment this for simulating local lambda invoke
magpie_model = MagpieModel(model_dir)

def predict(event,context):

    logger.info('Event : {}'.format(event))
    logger.info('Event text : {}'.format(event['text']))
    text = event['text']
    
    predicted_text = magpie_model.predict_from_text(text)
    logger.info('Predicted text : {}'.format(predicted_text))

    return {
        "result": np.array(predicted_text).tolist()
    }


if __name__ == "__main__":
    predict('', '')