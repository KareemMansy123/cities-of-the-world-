<h1>Cities of the World App</h1>

<h2>Overview</h2>

<p>The <strong>Cities of the World</strong> app is a modular Flutter application designed to allow users to explore, search, and view information about various cities worldwide. Built with a focus on scalability and clean architecture, the app makes extensive use of modern Flutter libraries and best practices to ensure high performance and ease of maintainability.</p>

<h3>Key Features</h3>
<ul>
  <li><strong>Search and View Cities</strong>: Allows users to search for cities and view details.</li>
  <li><strong>Infinite Scrolling</strong>: Data is loaded in pages as the user scrolls down the list, improving performance.</li>
  <li><strong>Map Integration</strong>: Navigate to city locations via Google Maps.</li>
  <li><strong>Theme Switching</strong>: Toggle between light and dark themes.</li>
  <li><strong>Offline Caching</strong>: Stores city data using Hive, allowing offline access and improving load times.</li>
</ul>

<h2>Table of Contents</h2>
<ol>
  <li><a href="#tech-stack">Tech Stack</a></li>
  <li><a href="#installation-and-setup">Installation and Setup</a></li>
  <li><a href="#architecture">Architecture</a></li>
  <li><a href="#folder-structure">Folder Structure</a></li>
  <li><a href="#dependency-injection-with-getit">Dependency Injection with GetIt</a></li>
  <li><a href="#state-management-with-bloc">State Management with BLoC</a></li>
  <li><a href="#local-caching-with-hive">Local Caching with Hive</a></li>
  <li><a href="#error-handling">Error Handling</a></li>
  <li><a href="#modular-design">Modular Design</a></li>
  <li><a href="#contributions">Contributions</a></li>
</ol>

<h2 id="tech-stack">Tech Stack</h2>
<ul>
  <li><strong>Flutter</strong>: Frontend UI toolkit.</li>
  <li><strong>Hive</strong>: Lightweight, NoSQL database for local caching.</li>
  <li><strong>Dio</strong>: HTTP client for API calls.</li>
  <li><strong>GetIt</strong>: Service locator for dependency injection.</li>
  <li><strong>BLoC</strong>: Business logic component for predictable and testable state management.</li>
  <li><strong>Modular Architecture</strong>: Clean code structure that isolates business logic, UI, and data access layers.</li>
</ul>

<h2 id="installation-and-setup">Installation and Setup</h2>

<h3>Prerequisites</h3>
<ul>
  <li>Flutter SDK (v2.0 or higher)</li>
  <li>Dart SDK (v2.12 or higher)</li>
  <li>A code editor, like VS Code or Android Studio</li>
</ul>

<h3>Instructions</h3>
<ol>
  <li>Clone the repository:
    <pre><code>git clone https://github.com/Kareemmansy123/cities_of_the_world.git</code></pre>
  </li>
  <li>Install dependencies:
    <pre><code>flutter pub get</code></pre>
  </li>
  <li>Set up Hive storage:
    <p>Hive requires initializing with a directory to store data. This setup is handled in the dependency injection configuration.</p>
  </li>
  <li>Run the app:
    <pre><code>flutter run</code></pre>
  </li>
</ol>

<h2 id="architecture">Architecture</h2>

<p>This project employs a <strong>Clean Architecture</strong> and <strong>Modular Design</strong> to separate UI, business logic, and data layers. The main principles include:</p>
<ul>
  <li><strong>Modularity</strong>: Code is organized into feature-based modules.</li>
  <li><strong>Dependency Injection</strong>: The <code>GetIt</code> service locator manages dependencies.</li>
  <li><strong>Reactive Programming</strong>: BLoC (Business Logic Component) pattern ensures reactive and predictable state management.</li>
  <li><strong>Offline First</strong>: Local caching with Hive enhances user experience during network issues.</li>
</ul>

<h2 id="folder-structure">Folder Structure</h2>

<ul>
  <li><strong>lib/</strong>: Main source directory.
    <ul>
      <li><strong>app/</strong>: Application-level components, including dependency injection.</li>
      <li><strong>blocs/</strong>: Contains the BLoC classes to manage state.</li>
      <li><strong>models/</strong>: Data models and Hive adapters.</li>
      <li><strong>repository/</strong>: Contains repositories that interact with APIs or local storage.</li>
      <li><strong>screens/</strong>: UI components, broken down into pages and widgets.</li>
      <li><strong>services/</strong>: Includes services like API calls and data manipulation.</li>
      <li><strong>utils/</strong>: Utility functions, error handling, and constants.</li>
    </ul>
  </li>
</ul>

<h2 id="dependency-injection-with-getit">Dependency Injection with GetIt</h2>

<p>Dependency injection is set up using <strong>GetIt</strong>, which allows us to manage dependencies centrally and promotes reusability.</p>

<h3>Setting Up Dependencies</h3>

<pre><code>Future&lt;void&gt; setupInjection() async {
  Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(CityAdapter());
  final cityBox = await Hive.openBox&lt;City&gt;('cityBox');

  getIt.registerSingleton&lt;Box&lt;City&gt;&gt;(cityBox);
  getIt.registerSingleton&lt;ApiService&gt;(ApiService(Dio()));
  getIt.registerSingleton&lt;CityRepository&gt;(
    CityRepository(apiService: getIt&lt;ApiService&gt;(), cityBox: getIt&lt;Box&lt;City&gt;&gt;()),
  );

  getIt.registerFactory&lt;AppBloc&gt;(() =&gt; AppBloc());
  getIt.registerFactory&lt;CityBloc&gt;(() =&gt; CityBloc(getIt&lt;CityRepository&gt;()));
}</code></pre>

<h2 id="state-management-with-bloc">State Management with BLoC</h2>

<p>The BLoC pattern is used to separate UI from business logic, ensuring a clear, reactive, and testable state management solution.</p>

<h3>Example</h3>

<p>Each feature (like city fetching, theme toggling) has a dedicated BLoC:</p>

<pre><code>class CityBloc extends Bloc&lt;CityEvent, CityState&gt; {
  final CityRepository cityRepository = GetIt.I&lt;CityRepository&gt;();

  CityBloc() : super(CityLoadingState()) {
    on&lt;LoadCitiesEvent&gt;(_onLoadCities);
    on&lt;LoadMoreCitiesEvent&gt;(_onLoadMoreCities);
    on&lt;SearchCitiesEvent&gt;(_onSearchCities);
  }
}</code></pre>

<p>BLoC listens to events like <code>LoadCitiesEvent</code> and <code>SearchCitiesEvent</code>, interacts with the <code>CityRepository</code>, and emits states like <code>CityLoadedState</code> or <code>CityErrorState</code>.</p>

<h2 id="local-caching-with-hive">Local Caching with Hive</h2>

<p>Hive is used for efficient local storage, allowing users to retrieve data offline and enhancing load times.</p>

<h3>Example of Caching Cities</h3>

<p>The 10 most recent city data entries are cached to prevent excessive data buildup:</p>

<pre><code>Future&lt;void&gt; _cacheRecentCities(List&lt;City&gt; cities) async {
  final recentCities = cities.take(10).toList();
  await cityBox.clear();
  for (var city in recentCities) {
    await cityBox.put(city.id, city);
  }
}</code></pre>

<p>This ensures that local data is up-to-date without overwhelming local storage.</p>

<h2 id="error-handling">Error Handling</h2>

<p>All network calls are wrapped with custom error handling for user-friendly feedback. <strong>Dio</strong> is used to handle network errors, and a centralized error handler displays relevant messages.</p>

<h3>Example Error Handler</h3>

<pre><code>class ErrorHandler {
  static void handleError(dynamic error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
          _showErrorDialog('Connection Timeout', 'Check your connection.');
          break;
        case DioErrorType.response:
          _showErrorDialog('Error ${error.response?.statusCode}', error.response?.statusMessage ?? 'Unknown error');
          break;
        default:
          _showErrorDialog('Unexpected Error', 'Something went wrong.');
      }
    } else {
      _showErrorDialog('Error', 'An unexpected error occurred.');
    }
  }
}</code></pre>

<h2 id="modular-design">Modular Design</h2>

<p>The app is structured to be highly modular, with each feature encapsulated within its own folder. This organization ensures that each module can be maintained, tested, or updated independently, improving scalability.</p>

<h3>Example Modules</h3>
<ul>
  <li><strong>City Module</strong>: Contains UI, BLoC, and repository specific to city management.</li>
  <li><strong>App Module</strong>: Handles general app-level logic, like theme management and dependency injection.</li>
</ul>

<h2 id="contributions">Contributions</h2>

<p>Contributions are welcome! If you'd like to make improvements, please follow the standard GitHub process:</p>
<ol>
  <li>Fork the repository.</li>
  <li>Create a new branch with a descriptive name.</li>
  <li>Submit a pull request for review.</li>
</ol>

<h2>License</h2>

<p>This project is licensed under the MIT License.</p>
