import json

from ultralytics import YOLO


def get_latest_image(directory):
    images = [f for f in os.listdir(directory) if f.lower().endswith(('.png', '.jpg', '.jpeg', '.gif'))]
    if images:
        latest_image = max(images, key=lambda f: os.path.getmtime(os.path.join(directory, f)))
        return latest_image
    else:
        return None

model = YOLO("D:\Hoc\Pycharm_Project\Simple_Flask\yolov8n.pt")  # pretrained YOLOv8n model

# model.predict('bus.jpg', project="result",  conf=0.5, save=True, max_det = 1)

# results = model.predict('bus.jpg', project="result",  conf=0.5, save=True, max_det = 1)
result_1 = model('bus.jpg', project="result",  conf=0.5,  max_det = 1, show_labels= True)
result_dict = json.loads(result_1[0].tojson())

# Extract the "name" field
name = result_dict[0]['name']



print(name)

# for result in results:
#     result.save('static/bus_detected.jpg')

