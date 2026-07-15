#pragma once
#include <cstdarg>
namespace Eloquent {
    namespace ML {
        namespace Port {
            class RandomForest {
                public:
                    /**
                    * Predict class for features vector
                    */
                    int predict(float *x) {
                        uint8_t votes[2] = { 0 };
                        // tree #1
                        if (x[0] <= 11.050000190734863) {
                            votes[1] += 1;
                        }

                        else {
                            if (x[1] <= 31.19999885559082) {
                                votes[0] += 1;
                            }

                            else {
                                if (x[2] <= 45.44999885559082) {
                                    if (x[2] <= 44.10000038146973) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }
                        }

                        // tree #2
                        if (x[2] <= 48.39999961853027) {
                            if (x[2] <= 45.39999961853027) {
                                if (x[2] <= 44.85000038146973) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }

                            else {
                                if (x[2] <= 46.85000038146973) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }
                        }

                        else {
                            if (x[1] <= 16.949999809265137) {
                                votes[1] += 1;
                            }

                            else {
                                if (x[0] <= 10.949999809265137) {
                                    votes[1] += 1;
                                }

                                else {
                                    if (x[2] <= 73.75) {
                                        if (x[2] <= 50.69999885559082) {
                                            votes[0] += 1;
                                        }

                                        else {
                                            votes[0] += 1;
                                        }
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }
                            }
                        }

                        // tree #3
                        if (x[1] <= 17.050000190734863) {
                            votes[1] += 1;
                        }

                        else {
                            if (x[1] <= 31.899999618530273) {
                                if (x[1] <= 24.050000190734863) {
                                    if (x[0] <= 11.050000190734863) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }

                            else {
                                if (x[2] <= 45.05000114440918) {
                                    votes[1] += 1;
                                }

                                else {
                                    if (x[2] <= 45.89999961853027) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }
                            }
                        }

                        // tree #4
                        if (x[2] <= 90.25) {
                            if (x[1] <= 32.25) {
                                if (x[0] <= 11.099999904632568) {
                                    if (x[0] <= 10.849999904632568) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }

                            else {
                                if (x[1] <= 33.64999961853027) {
                                    if (x[0] <= 17.59999942779541) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }
                        }

                        else {
                            if (x[1] <= 17.149999618530273) {
                                votes[1] += 1;
                            }

                            else {
                                votes[0] += 1;
                            }
                        }

                        // tree #5
                        if (x[2] <= 90.35000228881836) {
                            if (x[1] <= 32.85000038146973) {
                                if (x[0] <= 11.099999904632568) {
                                    if (x[0] <= 10.849999904632568) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    if (x[0] <= 17.75) {
                                        votes[0] += 1;
                                    }

                                    else {
                                        if (x[0] <= 19.25) {
                                            votes[0] += 1;
                                        }

                                        else {
                                            votes[0] += 1;
                                        }
                                    }
                                }
                            }

                            else {
                                if (x[2] <= 44.75) {
                                    votes[1] += 1;
                                }

                                else {
                                    if (x[2] <= 45.89999961853027) {
                                        if (x[2] <= 45.25) {
                                            votes[1] += 1;
                                        }

                                        else {
                                            votes[1] += 1;
                                        }
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }
                            }
                        }

                        else {
                            if (x[0] <= 10.950000286102295) {
                                votes[1] += 1;
                            }

                            else {
                                votes[0] += 1;
                            }
                        }

                        // tree #6
                        if (x[1] <= 17.050000190734863) {
                            if (x[1] <= 16.84999942779541) {
                                votes[1] += 1;
                            }

                            else {
                                votes[1] += 1;
                            }
                        }

                        else {
                            if (x[1] <= 33.0) {
                                if (x[1] <= 20.15000057220459) {
                                    if (x[1] <= 18.350000381469727) {
                                        if (x[2] <= 90.29999923706055) {
                                            votes[0] += 1;
                                        }

                                        else {
                                            votes[0] += 1;
                                        }
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }

                                else {
                                    if (x[1] <= 23.850000381469727) {
                                        if (x[0] <= 12.349999904632568) {
                                            votes[1] += 1;
                                        }

                                        else {
                                            votes[0] += 1;
                                        }
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }
                            }

                            else {
                                if (x[2] <= 45.25) {
                                    votes[1] += 1;
                                }

                                else {
                                    if (x[1] <= 33.64999961853027) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }
                            }
                        }

                        // tree #7
                        if (x[1] <= 16.949999809265137) {
                            votes[1] += 1;
                        }

                        else {
                            if (x[2] <= 48.30000114440918) {
                                if (x[2] <= 45.89999961853027) {
                                    if (x[1] <= 33.60000038146973) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }

                            else {
                                if (x[2] <= 84.75) {
                                    if (x[1] <= 24.0) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }

                                else {
                                    if (x[2] <= 89.0) {
                                        votes[0] += 1;
                                    }

                                    else {
                                        if (x[0] <= 11.299999713897705) {
                                            votes[1] += 1;
                                        }

                                        else {
                                            votes[0] += 1;
                                        }
                                    }
                                }
                            }
                        }

                        // tree #8
                        if (x[0] <= 10.949999809265137) {
                            votes[1] += 1;
                        }

                        else {
                            if (x[1] <= 31.44999885559082) {
                                if (x[2] <= 75.45000076293945) {
                                    if (x[1] <= 26.800000190734863) {
                                        votes[0] += 1;
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }

                            else {
                                if (x[0] <= 24.649999618530273) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }
                        }

                        // tree #9
                        if (x[2] <= 90.75) {
                            if (x[1] <= 31.899999618530273) {
                                if (x[0] <= 11.050000190734863) {
                                    if (x[0] <= 10.849999904632568) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }

                            else {
                                if (x[1] <= 33.60000038146973) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }
                        }

                        else {
                            votes[1] += 1;
                        }

                        // tree #10
                        if (x[0] <= 10.949999809265137) {
                            votes[1] += 1;
                        }

                        else {
                            if (x[1] <= 31.899999618530273) {
                                if (x[0] <= 11.150000095367432) {
                                    votes[0] += 1;
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }

                            else {
                                if (x[0] <= 23.649999618530273) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }
                        }

                        // tree #11
                        if (x[0] <= 10.949999809265137) {
                            votes[1] += 1;
                        }

                        else {
                            if (x[2] <= 48.30000114440918) {
                                if (x[0] <= 24.149999618530273) {
                                    if (x[2] <= 46.14999961853027) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }

                            else {
                                if (x[2] <= 75.4000015258789) {
                                    votes[0] += 1;
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }
                        }

                        // tree #12
                        if (x[2] <= 89.75) {
                            if (x[1] <= 32.85000038146973) {
                                if (x[0] <= 11.050000190734863) {
                                    if (x[1] <= 17.949999809265137) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    if (x[2] <= 48.04999923706055) {
                                        votes[0] += 1;
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }
                            }

                            else {
                                if (x[2] <= 45.89999961853027) {
                                    if (x[2] <= 45.05000114440918) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        votes[1] += 1;
                                    }
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }
                        }

                        else {
                            if (x[2] <= 90.70000076293945) {
                                if (x[0] <= 10.950000286102295) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }

                            else {
                                votes[1] += 1;
                            }
                        }

                        // tree #13
                        if (x[2] <= 48.45000076293945) {
                            if (x[0] <= 25.050000190734863) {
                                if (x[0] <= 19.350000381469727) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }

                            else {
                                votes[0] += 1;
                            }
                        }

                        else {
                            if (x[1] <= 17.199999809265137) {
                                votes[1] += 1;
                            }

                            else {
                                if (x[1] <= 21.25) {
                                    votes[0] += 1;
                                }

                                else {
                                    if (x[1] <= 24.0) {
                                        if (x[1] <= 22.5) {
                                            if (x[2] <= 87.6500015258789) {
                                                votes[0] += 1;
                                            }

                                            else {
                                                votes[0] += 1;
                                            }
                                        }

                                        else {
                                            votes[1] += 1;
                                        }
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }
                            }
                        }

                        // tree #14
                        if (x[2] <= 90.25) {
                            if (x[0] <= 10.949999809265137) {
                                votes[1] += 1;
                            }

                            else {
                                if (x[1] <= 31.899999618530273) {
                                    if (x[0] <= 11.150000095367432) {
                                        votes[0] += 1;
                                    }

                                    else {
                                        votes[0] += 1;
                                    }
                                }

                                else {
                                    if (x[1] <= 33.05000114440918) {
                                        votes[1] += 1;
                                    }

                                    else {
                                        if (x[2] <= 45.35000038146973) {
                                            votes[1] += 1;
                                        }

                                        else {
                                            votes[1] += 1;
                                        }
                                    }
                                }
                            }
                        }

                        else {
                            if (x[0] <= 10.950000286102295) {
                                votes[1] += 1;
                            }

                            else {
                                votes[0] += 1;
                            }
                        }

                        // tree #15
                        if (x[1] <= 17.09999942779541) {
                            votes[1] += 1;
                        }

                        else {
                            if (x[1] <= 31.649999618530273) {
                                if (x[0] <= 11.050000190734863) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[0] += 1;
                                }
                            }

                            else {
                                if (x[1] <= 33.35000038146973) {
                                    votes[1] += 1;
                                }

                                else {
                                    votes[1] += 1;
                                }
                            }
                        }

                        // return argmax of votes
                        uint8_t classIdx = 0;
                        float maxVotes = votes[0];

                        for (uint8_t i = 1; i < 2; i++) {
                            if (votes[i] > maxVotes) {
                                classIdx = i;
                                maxVotes = votes[i];
                            }
                        }

                        return classIdx;
                    }

                protected:
                };
            }
        }
    }