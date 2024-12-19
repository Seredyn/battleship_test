import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/field_bloc.dart';
import '../bloc/field_event.dart';
import '../bloc/field_state.dart';

class PlacementScreen extends StatelessWidget {
  const PlacementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Получение ширины и высоты контейнера
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;

      return BlocProvider(
        create: (_) => FieldBloc(),
        // Ініціалізація BLoC для управління станом
        child: Scaffold(
          appBar: AppBar(title: Text('Розстав кораблі')),
          // Заголовок сторінки
          body: Column(
            children: [
              // Основна частина: Поле розміщення кораблів
              Expanded(
                child: BlocBuilder<FieldBloc, FieldState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        LayoutBuilder(builder: (context, constraints) {
                          return Row(
                            children: [
                              const SizedBox(width: 30),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(10, (index) {
                                    // Генерация символа, начиная с 'A'
                                    String letter = String.fromCharCode(
                                        65 + index); // 65 — это код символа 'A'
                                    return SizedBox(
                                        width: (constraints.maxWidth - 30) / 10,
                                        child: Center(child: Text(letter)));
                                  }),
                                ),
                              ),
                            ],
                          );
                        }),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child: Column(
                                  children: List.generate(10, (index) {
                                    return SizedBox(
                                        height:
                                            (constraints.maxWidth - 30) / 10,
                                        child: Center(
                                            child: Text('${index + 1}')));
                                  }),
                                ),
                              ),
                              Expanded(
                                child: GridView.builder(
                                  // Визначаємо 10x10 поле
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 10, // Кількість стовпців
                                  ),
                                  itemCount: 100, // Всього 100 клітинок
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final x = index ~/ 10; // Визначаємо рядок
                                    final y = index % 10; // Визначаємо стовпець

                                    final isHovered = state.hoveredCells[x]
                                        [y]; // Чи підсвічена ця клітинка

                                    return DragTarget<Map<String, dynamic>>(
                                      key: ValueKey('cell_${x}_$y'),
                                      // Унікальний ключ для кожної клітинки
                                      // Під час перетягування: перевіряємо можливість розміщення
                                      onWillAccept: (data) {
                                        context.read<FieldBloc>().add(
                                              HoverShipEvent(
                                                  x,
                                                  y,
                                                  data!['length'],
                                                  data['horizontal']),
                                            );
                                        return true; // Завжди дозволяємо перетягування (перевірка в BLoC)
                                      },
                                      // Під час завершення перетягування: додаємо корабель
                                      onAccept: (data) {
                                        context.read<FieldBloc>().add(
                                              PlaceShipEvent(
                                                  x,
                                                  y,
                                                  data['length'],
                                                  data['horizontal']),
                                            );
                                      },
                                      // Коли перетягування залишає цю клітинку: прибираємо підсвічування
                                      onLeave: (_) {
                                        context
                                            .read<FieldBloc>()
                                            .add(ClearHoverEvent());
                                      },
                                      // Побудова інтерфейсу кожної клітинки
                                      builder: (context, candidateData,
                                          rejectedData) {
                                        return Container(
                                          margin: EdgeInsets.all(2),
                                          // Проміжки між клітинками
                                          color: isHovered
                                              ? Colors.green.withOpacity(
                                                  0.6) // Зелений: можна розмістити
                                              : (state.field[x][y] ==
                                                      0 // Червоний: не можна розмістити
                                                  ? Colors.blue[
                                                      200] // Синій: порожня клітинка
                                                  : Colors
                                                      .green), // Зелений: клітинка зайнята
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // SizedBox(height: 20),
              // Text('with: $width'),
              // Text('height: $height'),
              SizedBox(height: 20),
              // Панель для розміщення кораблів
              BlocBuilder<FieldBloc, FieldState>(
                builder: (context, state) {
                  // Генеруємо список доступних кораблів
                  final availableShips = state.availableShips.entries
                      .where(
                          (entry) => entry.value > 0) // Лише ті, що ще доступні
                      .expand((entry) => List.generate(
                          entry.value, (_) => entry.key)) // Створюємо список
                      .toList();

                  return availableShips.isNotEmpty
                      ? Wrap(
                          spacing: 16, // Відстань між елементами
                          runSpacing: 16,
                          children: availableShips.map((length) {
                            return DraggableShip(
                                key: GlobalKey(),
                                length:
                                    length); // Створюємо інтерактивний корабель
                          }).toList(),
                        )
                      : FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("It's time to play!")));
                          },
                          child: const Text("PLAY"));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class DraggableShip extends StatefulWidget {
  final int length; // Довжина корабля

  const DraggableShip({super.key, required this.length});

  @override
  _DraggableShipState createState() => _DraggableShipState();
}

class _DraggableShipState extends State<DraggableShip> {
  bool isHorizontal = true; // Початкова орієнтація корабля: горизонтальна

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        // Змінюємо орієнтацію корабля при подвійній дії (double tap)
        setState(() {
          isHorizontal = !isHorizontal;
        });
      },
      child: Draggable<Map<String, dynamic>>(
        // Передаємо дані про корабель (довжина та орієнтація)
        data: {'length': widget.length, 'horizontal': isHorizontal},
        // Під час перетягування: зображення корабля
        feedback: isHorizontal
            ? Row(children: buildChildren())
            : Column(
                children: buildChildren(),
              ),
        // Початковий вигляд корабля
        child: isHorizontal
            ? Row(mainAxisSize: MainAxisSize.min, children: buildChildren())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: buildChildren(),
              ),
      ),
    );
  }

  List<Widget> buildChildren() {
    return List.generate(
      widget.length,
      (index) => Container(
        width: 30,
        height: 30,
        color: Colors.blue, // Синій колір
        margin: EdgeInsets.all(2),
      ),
    );
  }
}
