import 'dart:async';

class AfrocastStreamFeed<T> {

  AfrocastStreamFeed() {
//    this.outputStreamFeed.listen((data) => print("Incoming data: $data"));
  }

  StreamController<List<T>> feedController = new StreamController<List<T>>.broadcast();
  StreamController<List<T>> singleFeedController = new StreamController<List<T>>.broadcast();

  StreamSink<List<T>> get inputStreamFeed =>  feedController.sink;

  Stream<List<T>> get outputStreamFeed => feedController.stream;



  StreamSink<List<T>> get singleInputStreamFeed =>  singleFeedController.sink;

  Stream<List<T>> get singleOutputStreamFeed => singleFeedController.stream;

  dispose() {
    this.singleFeedController.close();
  }

  dispose2() {
    this.feedController.close();
  }
}