import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/constants/resources.dart';
import 'package:flutter_app/widgets/app_bar.dart';
import 'package:flutter_app/widgets/brightness_observer.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/widgets/cell.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

class BackupPage extends HookWidget {
  const BackupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrightnessData.themeOf(context).background,
      appBar: MixinAppBar(
        title: Text(Localization.of(context).chatBackup),
        actions: [],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            SvgPicture.asset(
              Resources.assetsImagesChatBackupSvg,
              width: 88,
              height: 88,
              color: BrightnessData.themeOf(context).secondaryText,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 500,
              child: Text(
                Localization.of(context).chatBackupDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: BrightnessData.themeOf(context).secondaryText,
                ),
              ),
            ),
            const SizedBox(height: 30),
            CellGroup(
              child: CellItem(
                title: Text(Localization.of(context).backup),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, bottom: 14, top: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                '',
                style: TextStyle(
                  color: BrightnessData.themeOf(context).secondaryText,
                  fontSize: 14,
                ),
              ),
            ),
            CellGroup(
              child: Column(
                children: [
                  CellItem(
                    title: Text(Localization.of(context).autoBackup),
                    trailing: CupertinoSwitch(
                      activeColor: BrightnessData.themeOf(context).accent,
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ),
                  CellItem(
                    title: Text(Localization.of(context).includeFiles),
                    trailing: CupertinoSwitch(
                      activeColor: BrightnessData.themeOf(context).accent,
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ),
                  CellItem(
                    title: Text(Localization.of(context).includeVideos),
                    trailing: CupertinoSwitch(
                      activeColor: BrightnessData.themeOf(context).accent,
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}