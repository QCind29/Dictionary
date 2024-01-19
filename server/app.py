import base64
import binascii
import datetime
import io
import json
import os
import shutil

import ultralytics
from flask import Flask, jsonify, request, send_file, send_from_directory
from flask_cors import CORS
from ultralytics import YOLO

app = Flask(__name__)
CORS(app)
app.config['CORS_HEADERS'] = 'Content-type'
app.config['UPLOAD_FOLDER']= 'static'

detected_folder = r'C:\Users\ADMIN\Desktop\Github\My project\Flutter\Y8-Dictionary\server\result\predict'


model = YOLO("yolov8n.pt")

@app.route("/")
def API_STATUS():
    return f' API is work!'

@app.route("/1")
def API_CHECK():
    try:
        data = []
        results = model.predict('bus.jpg', save = True, project ="result", conf=0.5, max_det = 1)
        json_data =json.loads(results[0].tojson())
        name = json_data[0]['name']
        # base64_data = image_to_base64('bus.jpg')
        base64_data = get_latest_image(detected_folder)
        data.append({'image':base64_data, 'object': name })


        return jsonify({'image': base64_data, 'object': name })
       
       
    except Exception as e:
        return jsonify({'error': str(e)}), 500





@app.route("/2", methods = ['POST'])
def hello_world2():
    try:
        data1 = []
        # latest_image_input = get_latest_image(app.config['UPLOAD_FOLDER'])
        # os.remove(latest_image_input)
        image = request.files['file']
        #Clean predic folder
        shutil.rmtree(detected_folder)

        if image :
            path_to_save  = os.path.join(app.config['UPLOAD_FOLDER'], image.filename)
            print("Save = ", path_to_save)
            image.save(path_to_save)
            # Detected image
            results = model.predict(path_to_save, save = True, project ="result", conf=0.5, max_det = 1)
            # Convert object to Json type
            json_data =json.loads(results[0].tojson())
            # Get 'name' field in Json file
            name = json_data[0]['name']

            #Convert image detected to base64
            base64_data = get_latest_image(detected_folder)

            data1.append({'image':base64_data, 'object': name })

            return jsonify({'image': base64_data, 'object': name })
        else:
            return f'Have no image in folder'
    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route("/3", methods = ['POST'])
def hello_world3():
    # base64_string = request.data.decode('utf-8')
    img_file = request.files['file']
    if base64_string:
        try:
            image_data = base64.b64decode(base64_string)
            filename = f"{datetime.datetime.now().timestamp()}.jpg"
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            with open(file_path, 'wb') as file:
                file.write(image_data)

            #Clean predic folder
            shutil.rmtree(detected_folder)
       
            # Detected image
            results = model.predict(file_path, save = True, project ="result", conf=0.5, max_det = 1)
                # Convert object to Json type
            json_data =json.loads(results[0].tojson())
                # Get 'name' field in Json file
            name = json_data[0]['name']

                #Convert image detected to base64
            base64_data = get_latest_image(detected_folder)

            # data1.append({'image':base64_data, 'object': name })

            return jsonify({'image': base64_data, 'object': name })
          
        except Exception as e:
            return jsonify({'error': str(e)}), 500

#  Get lastest image detected from predict folder and covert to base64 type
def get_latest_image(directory):
    images = [f for f in os.listdir(directory) if f.lower().endswith(('.png', '.jpg', '.jpeg', '.gif'))]
    for image in images:
        image_path = os.path.join(detected_folder, image)
        with open(image_path, 'rb') as image_file:
            base64_data = base64.b64encode(image_file.read()).decode('utf-8')
        return base64_data
    else:
        return None
    

def image_to_base64(image_path):
    with open(image_path, "rb") as image_file:
        # Read the image file as binary data
        image_binary = image_file.read()

        # Convert binary data to base64-encoded string
        base64_string = base64.b64encode(image_binary).decode("utf-8")

    return base64_string




#save image from client
def save_base64_image(base64_string):
    try:
        # Decode the base64 string
        image_data = base64.b64decode(base64_string)
        filename = f"{datetime.datetime.now().timestamp()}.jpg"
        # Save the image to the specified folder
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        with open(file_path, 'wb') as file:
            file.write(image_data)

        return file_path
    except binascii.Error as e:
        print(f'Error decoding base64: {e}')
        return None
    


if __name__ == '__main__':
    app.run(debug=True)