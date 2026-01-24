# Discussion of the convergence in the superconducting transition temperature (超導轉變溫度收斂問題討論)

$$
由於計算\lambda _{q}和\alpha ^{2}F(\omega )需要在Fermi-surface進行雙重\delta積分計算電子態密度,但電腦無法計算\delta方程,為了處理\delta方程,需要使用broadening(展寬)方法進行\delta方程近似:
$$

$$
Since{}calculating{} \lambda _{q}{}and{} \alpha ^{2}F(\omega ){}requires{}a{}double-\delta{}integration{}over{}the{}Fermi{}surface{}to{}evaluate{}the{}electronic{}density{}of{}states,{}and{}a{}computer{}cannot{}directly{}handle{}the{} \delta{}function,{}we{}need{}to{}approximate{}the{} \delta{}function{}using{}a{}broadening{}method:
$$

$$
broadening:I=\int_{BZ}^{}dq \int_{BZ}^{}d\epsilon f(k,q)\delta (\epsilon _{n,K}-\epsilon _{F})\delta (\epsilon _{n^{'} ,k^{'}}-\epsilon _{F})
$$

$$
QE中使用broadening法時,先將k點網格平均切割成的好幾個區間,每個區間中用一組'類似,模糊'的光滑連率函數去近似成尖銳地\delta方程(\sigma=degauss),去計算系統的電子佔據數,最終得到電子態密度.
$$

$$
In{}QE,{}when{}using{}the{}broadening{}method,{}the{}k-point{}grid{}is{}first{}divided{}into{}several{}small{}intervals.{}Within{}each{}interval,{}a{}smooth{}“smeared”{}function{}is{}used{}to{}approximate{}the{}sharp{} \delta{}function{}(\sigma=degauss){}in{}order{}to{}compute{}the{}electronic{}occupation{}numbers{}of{}the{}system.{}This{}procedure{}ultimately{}yields{}the{}electronic{}density{}of{}states{}(DOS).
$$

$$
將broadening引入後,雙重\delta積分近似為:
$$

$$
After{}introducing{}broadening,{}the{}double-\delta{}integration{}can{}be{}approximated{}as:
$$

$$
I\simeq \frac{\Omega _{BZ}^{2} }{N_{K} N_{q}} \sum_{k}^{} \sum_{q}^{}  \frac{1}{\sqrt{2\pi \sigma } }e^{-\frac{(\epsilon _{k}-\epsilon _{F})^{2}   }{\sigma ^{2} } } \frac{1}{\sqrt{2\pi \sigma } }e^{-\frac{(\epsilon _{k^{'}}-\epsilon _{F})^{2}   }{\sigma ^{2} } }   
$$

broadening法可以用費米-狄拉克分布去進行理解:

$$
The{}broadening{}method{}can{}be{}understood{}in{}terms{}of{}the{}Fermi–Dirac{}distribution:
$$

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/introduction%20to%20The%20theory%20of%20First%20principle/degauss.png)

$$
\sigma(degauss)便是控制費米-狄拉克分布參數平緩或陡峭的參數:\sigma值越小,費米-狄拉克分布越陡峭;,\sigma值越大,費米-狄拉克分布越平緩
$$

$$
The{}parameter{} \sigma(degauss){}controls{}how{}smooth{}or{}sharp{}the{}Fermi–Dirac{}distribution{}is:{}{}The{}smaller{} \sigma{}value,{}the{}Fermi–Dirac{}distribution{}is{}steeper.{}The{}larger{} \sigma{}value,{}the{}Fermi–Dirac{}distribution{}is{}smoother.
$$

k點網格平均切割成的區間,可以當成k(0.8-1.2)的範圍:k點網格切點值越疏,範圍越大;k點網格切點值越密,範圍越小

$$
The{}intervals{}created{}by{}averaging{}the{}k-point{}grid{}can{}be{}considered{}as{}a{}range,{}e.g.,{}k={} (0.8-1.2):{}The{}sparser{}k-point{}grid,{}which{}is{}larger{}than{}the{}range{}of{}each{}interval.;{}The{}denser{}k-point{}grid,{}which{}is{}smaller{}than{}the{}range{}of{}each{}interval.
$$

$$
從費米-狄拉克分布的圖可以注意到:k點網格切點密度需要和\sigma值匹配!倘若k點網格切點密度很高,\sigma很低,會造成低估電子態密度;倘若k點網格切點密度很小,\sigma很高,會造成嚴重高估電子態密度和導致數值計算補償,讓計算出的電子佔據數出現負值!
$$

$$
From{}the{}Fermi–Dirac{}distribution{}plot,{}we{}can{}observe{}that{}the{}density{}of{}k-point{}grid{}sampling{}must{}match{}the{} \sigma{}value!
$$

$$
If{}the{}k-point{}grid{}is{}very{}dense{}but{} \sigma{}is{}very{}small,{}it{}will{}underestimate{}the{}electronic{}density{}of{}states.
$$

$$
If{}the{}k-point{}grid{}is{}very{}sparse{}and{} \sigma{}is{}very{}large,{}it{}can{}seriously{}overestimate{}the{}electronic{}density{}of{}states{}and{}cause{}numerical{}compensation{}issues,{}even{}leading{}to{}negative{}electronic{}occupation{}numbers{}in{}the{}calculation.
$$

這裡列出了用plot_compare_tc.m讀取不同參數設置保存的全部degauss電聲耦合係數,電聲耦合權重和超導轉變溫度(V_61248_data.mat....),進行比較:

$$
Here,{}we{}list{}all{}the{}electron–phonon{}coupling{}constants,{}electron–phonon{}weights,{}and{}superconducting{}transition{}temperatures{}saved{}under{}different{}parameter{}settings{}(e.g.,{}V_61248_data.mat…){}as{}read{}by{}plot_compare_tc.m
$$

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/lambda1.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/omega_log1.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/T_c2%20.png)

以61248設置為例:第一個參數6是指ph.x計算的q點網格切點數,第二個參數12是第二步用來DFPT自洽的K點網格切點數,第三個參數48是第一步自準備計算電聲耦合係數(broadening法)中雙重狄拉克函數積分近似的能量採樣區間的較密K點網格切點數

$$
Taking{}the{}61248{}setup{}as{}an{}example:
$$

$$
The{}first{}parameter{}6{}refers{}to{}the{}number{}of{}q-points{}used{}in{}the{}ph.x{}calculation.
$$

$$
The{}second{}parameter{}12{}refers{}to{}the{}K-point{}grid{}used{}in{}the{}second{}step{}for{}DFPT{}self-consistent{}calculations.
$$

$$
The{}third{}parameter{}48{}refers{}to{}the{}denser{}K-point{}grid{}used{}in{}the{}first{}step{}to{}prepare{}for{}the{}electron–phonon{}coupling{}calculation{}(broadening{}method),{}i.e.,{}the{}energy{}sampling{}grid{}for{}the{}double-\delta{}function{}integration{}approximation.
$$

探討k點網格切點密度和degauss收斂只需調整第三個參數值,因此我們選了61854,61872和61890三個設置去進行比較全部degauss電聲耦合係數,電聲耦合權重和超導轉變溫度:

$$
To{}study{}the{}convergence{}of{}the{}k-point{}grid{}density{}and{}degauss,{}we{}only{}need{}to{}adjust{}the{}third{}parameter.{}Therefore,{}we{}selected{}the{}61854,{}61872,{}and{}61890{}setups{}to{}compare{}all{}the{}degauss{}electron–phonon{}coupling{}constants,{}electron–phonon{}weights,{}and{}superconducting{}transition{}temperatures.
$$

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/lambda3.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/omega_log3.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/T_c3%20.png)

可以看到61872在 degauss = 0.008 Ry 時,61872設置計算出來的電聲耦合強度,電聲耦合權重和超導轉變溫度值與最密的61890設置計算出來的值開始吻合,達成收斂,表示(72 * 72 * 72)的能量採樣區間和degauss = 0.008 Ry的平滑函數匹配!而61854則在 degauss = 0.012 Ry 時,61854設置計算出來的電聲耦合強度,電聲耦合權重和超導轉變溫度值與較密的61890和61872設置計算出來的值開始吻合,達成收斂,表示(54 * 54 * 54)的能量採樣區間和degauss = 0.012 Ry的平滑函數匹配!

$$
We{}can{}see{}that{}for{}the{}61872{}setup,{}at{}degauss{}={}0.008{}Ry,{}the{}electron–phonon{}coupling{}strength,{}electron–phonon{}weights,{}and{}superconducting{}transition{}temperature{}calculated{}with{}the{}61872{}grid{}begin{}to{}match{}those{}obtained{}with{}the{}densest{}61890{}setup,{}indicating{}convergence.{}This{}shows{}that{}the{}energy{}sampling{}grid{}of{}72×72×72{}matches{}well{}with{}the{}smoothing{}function{}at{}degauss{}={}0.008{}Ry.
$$

$$
Similarly,{}for{}the{}61854{}setup,{}at{}degauss{}={}0.012{}Ry,{}the{}calculated{}electron–phonon{}coupling{}strength,{}weights,{}and{}Tc{}start{}to{}match{}the{}values{}from{}the{}denser{}61890{}and{}61872{}setups,{}achieving{}convergence.{}This{}indicates{}that{}the{}54×54×54{}energy{}sampling{}grid{}matches{}well{}with{}the{}smoothing{}function{}at{}degauss{}={}0.012{}Ry.
$$

最終我們可以得到,61872設置配合degauss = 0.008 Ry得到的準確電聲耦合強度為1.4685,電聲耦合權重為200.335和超導轉變溫度為5.83433 K ,和V的實驗超導轉變溫度(5.4 K)相差不大!

$$
Finally,{}we{}can{}obtain{}that{}with{}the{}61872{}setup{}and{}degauss{}={}0.008{}Ry,{}the{}calculated{}values{}are:
$$

$$
Electron–phonon{}coupling{}strength:{}1.4685
$$

$$
Electron–phonon{}weight:{}200.335
$$

$$
Superconducting{}transition{}temperature{}(Tc):{}5.83433{}K
$$

$$
These{}results{}are{}quite{}close{}to{}the{}experimental{}superconducting{}transition{}temperature{}of{}V{}(5.4{}K)!
$$

# The main parameters affecting the superconducting transition temperature include:Screened Coulomb pseudo-potential (影響超導轉變溫度問題幾個主要參數:屏蔽庫侖pseudo-potential)

$$
根據McMillan-Allen{}Dynes{}function,得到\lambda和\omega _{log}後,便能初步推算材料的超導轉變溫度T_{c}:
$$

$$
According{}to{}the{}McMillan–Allen–Dynes{}function,{}once{} \lambda{}and{} \omega _{log}{}are{}obtained,{}the{}superconducting{}transition{}temperature{}Tc{}of{}the{}material{}can{}be{}preliminarily{}estimated:
$$

$$
T_{c}=\frac{\omega _{log} }{1.2}e^{[\frac{-1.04(1+\lambda ) }{\lambda-\mu ^{*}(1+0.62\lambda)   }] }
$$

$$
其中\mu ^{*}是屏蔽庫侖pseudo-potential,是半經驗參數,通常設值為0.1
$$

$$
Here,{} \mu ^{*}{}is{}the{}screened{}Coulomb{}pseudo-potential,{}a{}semi-empirical{}parameter,{}which{}is{}usually{}set{}to{}0.1.
$$

不過在V這個材料中, 屏蔽庫侖pseudo-potential值是0.368!

$$
However,{}for{}vanadium{}(V),{}the{}screened{}Coulomb{}pseudo-potential{}is{}0.368!
$$

我們可以在Tclambda.m中,調控mustar(pseudo-potential值)去計算超導轉變溫度,可以發現:若設mustar=0.1時,degauss = 0.008 Ry的超導轉變溫度為22.5 K,和V的實驗超導轉變溫度(5.4 K)相差非常大,和實驗不符,因此需要手動調整pseudo-potential值去貼合實驗值!

$$
We{}can{}adjust{}the{}mustar{}(pseudo-potential{}value){}in{}Tclambda.m{}to{}calculate{}the{}superconducting{}transition{}temperature,{}and{}we{}find{}that:
$$

$$
If{}we{}set{}mustar=0.1,{}the{}Tc{}calculated{}with{}degauss{}={}0.008{}Ry{}is{}22.5{}K,{}which{}is{}much{}higher{}than{}the{}experimental{}Tc{}of{}V{}(5.4{}K){}and{}clearly{}inconsistent{}with{}experiment.
$$

注:若想要求解pseudo-potential值,需使用SCDFT去計算!

# 影響超導轉變溫度問題幾個主要參數:第二步用來DFPT自洽的K點網格切點數

這裡列出了用plot_compare_tc.m讀取不同參數設置保存的全部degauss電聲耦合係數,電聲耦合權重和超導轉變溫度(V_61248_data.mat....),進行比較:

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/lambda1.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/omega_log1.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/T_c2%20.png)

可以注意到,若第二個參數的值為12(12 * 12 *12)的話,電聲耦合係數,電聲耦合權重和超導轉變溫度的計算值會過高;若第二個參數的值為16(16 * 16 *16)的話,電聲耦合係數,電聲耦合權重和超導轉變溫度的計算值會過低,只有第二個參數的值大於18(18 * 18 *18)的話,電聲耦合係數,電聲耦合權重和超導轉變溫度的計算值才不會過大,且和實驗值吻合,表示達成收斂!

我們可以用plot_compare_phononband.m畫出讀取不同第二個參數設置(12phonon_band_data...)保存的聲子譜比較圖和plot_compare_phonondos.m畫出讀取不同第二個參數設置(12dos_data...)保存的聲子態密度比較圖;可以發現:

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/phonon%20band%20q-mesh%20compare.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/phonondos%20k-mesh%20compare.png)

若第二個參數的值為12(12 * 12 *12)的話,造成計算出來的低頻聲子過多,導致其高估了電聲耦合係數,電聲耦合權重和超導轉變溫度;若第二個參數的值為16(16 * 16 *16)的話,造成計算出來的高頻聲子過多,導致其低估了電聲耦合係數,電聲耦合權重和超導轉變溫度;只有第二個參數的值大於18(18 * 18 *18)的話,計算出來的聲子性質才達成收斂且超導轉變溫度的計算值和實驗值吻合!

因此第二步用來DFPT自洽的K點網格切點數是否足夠密,是影響聲子計算準確度的重要參數!

