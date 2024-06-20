import 'package:flutter/material.dart';

class StatusServiceWidget extends StatelessWidget {
  const StatusServiceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        children: [
          Text('Status Serviços', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          SizedBox(
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aguar. Avaliação Técnica'),
                    Text('2'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aguar. Peças'),
                    Text('5'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aguar. Aprovação'),
                    Text('12'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Prontos'),
                    Text('3'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}