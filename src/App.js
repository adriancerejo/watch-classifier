import React, { Component } from "react";
import "./App.css";
import axios from "axios";
import Button from "@material-ui/core/Button";

const API_ENDPOINT = "http://127.0.0.1:5000";
const API_CLIENT = axios.create({
  baseURL: API_ENDPOINT,
});

class App extends Component {
  state = {
    imgSrc: "",
    selectedFile: null,
    predictions: null,
  };
  fileSelectedHandler = (event) => {
    this.setState({
      selectedFile: event.target.files[0],
    });

    if (event.target.files && event.target.files[0]) {
      let reader = new FileReader();
      reader.onload = (e) => {
        this.setState({ imgSrc: e.target.result });
      };
      reader.readAsDataURL(event.target.files[0]);
    }
  };

  fileUploadHandler = () => {
    var reader = new FileReader();

    const fd = new FormData();
    fd.append("image", this.state.selectedFile);
    API_CLIENT.post("/predict", fd).then((response) => {
      this.setState({ predictions: response.data });
    });
  };

  render() {
    if (this.state.predictions !== null) {
      var data = this.state.predictions.brandPredictions;

      var pred1 =
        data[0][0] +
        " with confidence of " +
        Math.round(data[0][1] * 100) +
        "%";
      var pred2 =
        data[1][0] +
        " with confidence of " +
        Math.round(data[1][1] * 100) +
        "%";
      var pred3 =
        data[2][0] +
        " with confidence of " +
        Math.round(data[2][1] * 100) +
        "%";
    }

    return (
      <div className="App">
        <header>Watch Brand Predictor</header>
        <div className="data">
          <input
            type="file"
            name="file"
            id="file"
            class="inputfile"
            onChange={this.fileSelectedHandler}
          />
          <label for="file">Choose a file</label>
          <Button
            variant="contained"
            color="primary"
            component="span"
            className="predict"
            onClick={this.fileUploadHandler}
          >
            Predict the Brand
          </Button>
        </div>
        <div className="predictions">
          <img id="target" src={this.state.imgSrc} />
          <ul>
            <li>{pred1}</li>
            <li>{pred2}</li>
            <li>{pred3}</li>
          </ul>
        </div>
      </div>
    );
  }
}

export default App;
