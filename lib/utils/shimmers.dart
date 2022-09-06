import 'package:flutter/material.dart';

SingleChildScrollView SecondShimmer(double height, double width) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        SizedBox(height: height * .03),
        Container(
          width: width * .85,
          height: height * .22,
          decoration: BoxDecoration(color: const Color.fromARGB(55, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(color: const Color.fromARGB(122, 158, 158, 158), width: width * .15, height: 15),
              SizedBox(height: height * .025),
              Container(color: const Color.fromARGB(122, 158, 158, 158), width: width * .5, height: 15),
              SizedBox(height: height * .01),
              Container(color: const Color.fromARGB(122, 158, 158, 158), width: width * .65, height: 15),
              SizedBox(height: height * .01),
              Container(color: const Color.fromARGB(122, 158, 158, 158), width: width * .3, height: 15),
              SizedBox(height: height * .01),
            ]),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(top: height * .03, left: width * .07, right: width * .07),
                  child: Container(
                      decoration: BoxDecoration(color: const Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                      width: width * .85,
                      height: height * .21,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(70, 158, 158, 158),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                          width: width * .38,
                          height: height * .21,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                width: width * .2,
                                height: height * .02,
                              ),
                              SizedBox(height: height * .005),
                              Container(
                                decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                width: width * .3,
                                height: height * .02,
                              ),
                              SizedBox(height: height * .005),
                              Container(
                                decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                width: width * .2,
                                height: height * .02,
                              ),
                              SizedBox(height: height * .02),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 13,
                                    backgroundColor: Color.fromARGB(70, 158, 158, 158),
                                  ),
                                  SizedBox(width: width * .035),
                                  Container(
                                    decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                    width: width * .2,
                                    height: height * .02,
                                  )
                                ],
                              ),
                              SizedBox(height: height * .02),
                              Container(
                                decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                width: width * .3,
                                height: height * .02,
                              ),
                            ],
                          ),
                        ),
                      ])));
            })
      ],
    ),
  );
}

ListView FirstShimmer(double height, double width) {
  return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.only(top: height * .03, left: width * .07, right: width * .05),
            child: Container(
                decoration: BoxDecoration(color: const Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                width: width * .34,
                height: height * .22,
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(70, 158, 158, 158),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                    width: width * .3,
                    height: height * .22,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                          width: width*.1,
                          height: height*.02,
                        ),
                        SizedBox(height: height*.01),
                        Container(
                          decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                          width: width*.5,
                          height: height*.02,
                        ),
                        SizedBox(height: height*.01),
                        Container(
                          decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                          width: width*.3,
                          height: height*.02,
                        ),
                        SizedBox(height: height*.02),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 13,
                              backgroundColor: Color.fromARGB(70, 158, 158, 158),
                            ),
                            SizedBox(width: width*.03),
                            Container(
                              decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                              width: width*.2,
                              height: height*.02,
                            )
                          ],
                        ),
                        SizedBox(height: height*.02),
                        Container(
                          decoration: const BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                          width: width*.2,
                          height: height*.02,
                        ),
                      ],
                    ),
                  )
                ])));
      });
}
