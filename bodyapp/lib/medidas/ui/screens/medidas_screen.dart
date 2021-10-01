import 'dart:math';
import 'dart:ui' as ui;
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class MedidasScreen extends StatelessWidget {
  const MedidasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Medidas'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 170 * 568 / height,
              right: 90 * 320 / width,

              width: 150 * 320 / width,
              height: 300 * 568 / height,
              child: Column(
                children: [
                  CustomPaint(
                    painter: new Gordura(),
                  ),
                  MeasureLabelWidget(
                    label: 'Gordura',
                    value: '170',
                  ),
                  SizedBox(height: 70 * 320 / height),
                  CustomPaint(
                    painter: new Imc(),
                  ),
                  MeasureLabelWidget(
                    label: 'IMC',
                    value: '22',
                  ),
                ],
              ),
            ),
            Positioned(
              height: height - (64 * 568 / height),
              child: Image.asset(
                'assets/images/women-silhouette.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: 8 * 568 / height,
              right: .3 * 320 / width,
              child: Text('atualizado em ${DateTime.now()}'),
            ),
            Positioned(
              right: 48 * 320 / width,
              top: 48 * 568 / height,
              child: Row(
                children: [
                  MeasureLabelWidget(
                    label: 'Altura',
                    value: '170',
                    measure: 'cm',
                  ),
                  SizedBox(width: 16 * 320 / width),
                  MeasureLabelWidget(
                    label: 'Peso',
                    value: '70',
                    measure: 'kg',
                  ),
                ],
              ),
            ),
            NestedMeasureWidget(
              top: 145 * 568 / height,
              left: 0,
              width: width * (.5 * 320 / width),
              label: 'Pescoço',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: (145 + 55) * 568 / height,
              left: 0,
              width: width * (.8 * 320 / width),
              label: 'Peito',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: (145 + 100) * 568 / height,
              left: 65 * 320 / width,
              width: width * (.38 * 320 / width),
              label: 'Biceps',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: (145 + 150) * 568 / height,
              left: 0,
              width: width * (.8 * 320 / width),
              label: 'Cintura',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: (145 + 190) * 568 / height,
              left: 25 * 320 / width,
              width: width * (.46 * 320 / width),
              label: 'Quadril',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: (145 + 270) * 568 / height,
              left: 20 * 320 / width,
              width: width * (.76 * 320 / width),
              label: 'Coxa',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: (145 + 370) * 568 / height,
              left: 17 * 320 / width,
              width: width * (.49 * 320 / width),
              label: 'Panturrilha',
              value: '95',
              measure: ' cm',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class NestedMeasureWidget extends StatelessWidget {
  NestedMeasureWidget({
    Key? key,
    required this.width,
    this.top = 0,
    this.left = 0,
    required this.label,
    required this.value,
    this.measure = '',
  }) : super(key: key);

  final double width;
  final double top;
  final double left;
  final String label;
  final String value;
  final String measure;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0, 
                  right: 8
                ),
                child: DottedLine(
                  dashGapLength: 8,
                ),
              ),
            ),
            MeasureLabelWidget(
              label: '$label',
              value: '$value',
              measure: '$measure',
            ),
          ],
        ),
      ),
    );
  }
}

class MeasureLabelWidget extends StatelessWidget {
  final String label;
  final String value;
  final String measure;

  const MeasureLabelWidget({
    Key? key,
    required this.label,
    required this.value,
    this.measure = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$label'),
        RichText(
          text: TextSpan(
            text: '$value',
            style: TextStyle(
              fontSize: 36,
            ),
            children: [
              TextSpan(
                text: ' $measure',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Gordura extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // create a bounding square, based on the centre and radius of the arc
    Rect rect = new Rect.fromCircle(
      center: new Offset(0.0, 0.0),
      radius: 90.0,
    );

    final Gradient gradient = new RadialGradient(
      colors: <Color>[
        Colors.blue.withOpacity(1.0),
        Colors.blue.withOpacity(0.9),
        Colors.green.withOpacity(1.0),
        Colors.red.withOpacity(0.9),
        Colors.red.withOpacity(1.0),
      ],
      stops: [
        0.0,
        0.3,
        0.5,
        0.7,
        1.0,
      ],
    );
    
    var paint = Paint()
    ..shader = gradient.createShader(rect)
    //..color = Colors.teal
    ..strokeWidth = 8
    ..style = PaintingStyle.stroke;
    
    final arc1 = Path();
    arc1.moveTo(-35, 22);
    arc1.arcToPoint(
      Offset(0, -13),
      radius: Radius.circular(35),
    );
    arc1.arcToPoint(
      Offset(0, 62),
      radius: Radius.circular(35),
    );
    canvas.drawPath(arc1, paint);
    //canvas.drawArc(rect, pi / 40, pi * 30 / 40, true, paint);
  }

  @override
  bool shouldRepaint(Imc oldDelegate) {
    return true;
  }
}

class Imc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // create a bounding square, based on the centre and radius of the arc
    Rect rect = new Rect.fromCircle(
      center: new Offset(0.0, 0.0),
      radius: 90.0,
    );

    final Gradient gradient = new RadialGradient(
      colors: <Color>[
        Colors.blue.withOpacity(1.0),
        Colors.blue.withOpacity(0.9),
        Colors.green.withOpacity(1.0),
        Colors.red.withOpacity(0.9),
        Colors.red.withOpacity(1.0),
      ],
      stops: [
        0.0,
        0.3,
        0.5,
        0.7,
        1.0,
      ],
    );
    
    var paint = Paint()
    ..shader = gradient.createShader(rect)
    //..color = Colors.teal
    ..strokeWidth = 8
    ..style = PaintingStyle.stroke;
    
    final arc1 = Path();
    arc1.moveTo(-35, 22);
    arc1.arcToPoint(
      Offset(0, -13),
      radius: Radius.circular(35),
    );
    arc1.arcToPoint(
      Offset(0, 62),
      radius: Radius.circular(35),
    );
    canvas.drawPath(arc1, paint);
    //canvas.drawArc(rect, pi / 40, pi * 30 / 40, true, paint);
  }

  @override
  bool shouldRepaint(Imc oldDelegate) {
    return true;
  }
}
