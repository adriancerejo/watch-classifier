from flask import Flask, request
import fastai.vision as fastai
from flask_cors import CORS, cross_origin
app = Flask(__name__)
CORS(app)

model = fastai.load_learner("./model", "watch-classifier.pkl")


@app.route("/predict", methods=["POST", "OPTIONS"])
def classify():
    files = request.files
    image = fastai.image.open_image(files['image'])
    prediction = model.predict(image)
    return {
        "brandPredictions": sorted(
            list(
                zip(
                    model.data.classes,
                    [round(x, 4) for x in map(float, prediction[2])]
                )
            ),
            key=lambda p: p[1],
            reverse=True
        )
    }


if __name__ == "__main__":
    app.run(debug=True)
