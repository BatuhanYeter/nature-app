import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class Chronometer extends StatefulWidget {
  @override
  _ChronometerState createState() => _ChronometerState();
}

class _ChronometerState extends State<Chronometer> {

  CountDownController _controller = CountDownController();
  TextEditingController durationController = TextEditingController();

  bool _isPause = true;
  int? duration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chronometer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircularCountDownTimer(
                autoStart: false,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                duration: duration ?? 60,
                fillColor: Colors.amber,
                controller: _controller,
                backgroundColor: Colors.white54,
                strokeWidth: 10.0,
                strokeCap: StrokeCap.round,
                isTimerTextShown: true,
                isReverse: false,
                initialDuration: 0,
                textStyle: TextStyle(fontSize: 50.0,color: Colors.black), ringColor: Colors.blue,
              ),
            ),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Set the duration',
                icon: Icon(Icons.timelapse),
              ),
            ),
            ElevatedButton(
              child: Text(
                "Set",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if(durationController.text.isEmpty)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a number"))
                  );
                else
                  setState(() {
                    duration = int.parse(durationController.text);
                    _controller.restart(duration: duration);
                    _isPause = false;
                  });
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            if(_isPause){
              _isPause = false;
              _controller.resume();
            }else{
              _isPause = true;
              _controller.pause();
            }
          });
        },
        icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
        label: Text(_isPause ? 'Start' : 'Pause'),
      ),
    );
  }
}