import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  String transformMilliseconds(int milliseconds) {
    var hundreds = (milliseconds / 10).truncate();
    var seconds = (hundreds / 100).truncate();
    var minutes = (seconds / 60).truncate();

    var minuteStr = (minutes % 60).toString().padLeft(2, '0');
    var secondStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minuteStr:$secondStr';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: _dragValue ?? widget.position.inMilliseconds.toDouble(),
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(Duration(milliseconds: value.round()));
            }     
          },
          onChangeEnd: (value) {
            _dragValue = null;
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd!(Duration(milliseconds: value.round()));
            }
          },
        ),
        // Text(
        //   "${transformMilliseconds(widget.position.inMilliseconds)}",
        //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        // )
      ],
    );
  }
}