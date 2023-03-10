import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UseEffect extends StatelessWidget {
  const UseEffect({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of(context);
    useEffect(() {
      print('effect');
      model.fetchList();
      return () => {};
    }, []);
    return const Placeholder();
  }
}
