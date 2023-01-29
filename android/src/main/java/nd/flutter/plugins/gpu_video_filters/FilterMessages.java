// Copyright 2022
// Autogenerated from Pigeon (v4.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package nd.flutter.plugins.gpu_video_filters;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class FilterMessages {

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class CreateFilterMessage {
    private @NonNull String fragmentShader;
    public @NonNull String getFragmentShader() { return fragmentShader; }
    public void setFragmentShader(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"fragmentShader\" is null.");
      }
      this.fragmentShader = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private CreateFilterMessage() {}
    public static final class Builder {
      private @Nullable String fragmentShader;
      public @NonNull Builder setFragmentShader(@NonNull String setterArg) {
        this.fragmentShader = setterArg;
        return this;
      }
      public @NonNull CreateFilterMessage build() {
        CreateFilterMessage pigeonReturn = new CreateFilterMessage();
        pigeonReturn.setFragmentShader(fragmentShader);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("fragmentShader", fragmentShader);
      return toMapResult;
    }
    static @NonNull CreateFilterMessage fromMap(@NonNull Map<String, Object> map) {
      CreateFilterMessage pigeonResult = new CreateFilterMessage();
      Object fragmentShader = map.get("fragmentShader");
      pigeonResult.setFragmentShader((String)fragmentShader);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class FilterMessage {
    private @NonNull Long filterId;
    public @NonNull Long getFilterId() { return filterId; }
    public void setFilterId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"filterId\" is null.");
      }
      this.filterId = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private FilterMessage() {}
    public static final class Builder {
      private @Nullable Long filterId;
      public @NonNull Builder setFilterId(@NonNull Long setterArg) {
        this.filterId = setterArg;
        return this;
      }
      public @NonNull FilterMessage build() {
        FilterMessage pigeonReturn = new FilterMessage();
        pigeonReturn.setFilterId(filterId);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("filterId", filterId);
      return toMapResult;
    }
    static @NonNull FilterMessage fromMap(@NonNull Map<String, Object> map) {
      FilterMessage pigeonResult = new FilterMessage();
      Object filterId = map.get("filterId");
      pigeonResult.setFilterId((filterId == null) ? null : ((filterId instanceof Integer) ? (Integer)filterId : (Long)filterId));
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class FloatFilterMessage {
    private @NonNull Long filterId;
    public @NonNull Long getFilterId() { return filterId; }
    public void setFilterId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"filterId\" is null.");
      }
      this.filterId = setterArg;
    }

    private @NonNull String name;
    public @NonNull String getName() { return name; }
    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull Double value;
    public @NonNull Double getValue() { return value; }
    public void setValue(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"value\" is null.");
      }
      this.value = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private FloatFilterMessage() {}
    public static final class Builder {
      private @Nullable Long filterId;
      public @NonNull Builder setFilterId(@NonNull Long setterArg) {
        this.filterId = setterArg;
        return this;
      }
      private @Nullable String name;
      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }
      private @Nullable Double value;
      public @NonNull Builder setValue(@NonNull Double setterArg) {
        this.value = setterArg;
        return this;
      }
      public @NonNull FloatFilterMessage build() {
        FloatFilterMessage pigeonReturn = new FloatFilterMessage();
        pigeonReturn.setFilterId(filterId);
        pigeonReturn.setName(name);
        pigeonReturn.setValue(value);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("filterId", filterId);
      toMapResult.put("name", name);
      toMapResult.put("value", value);
      return toMapResult;
    }
    static @NonNull FloatFilterMessage fromMap(@NonNull Map<String, Object> map) {
      FloatFilterMessage pigeonResult = new FloatFilterMessage();
      Object filterId = map.get("filterId");
      pigeonResult.setFilterId((filterId == null) ? null : ((filterId instanceof Integer) ? (Integer)filterId : (Long)filterId));
      Object name = map.get("name");
      pigeonResult.setName((String)name);
      Object value = map.get("value");
      pigeonResult.setValue((Double)value);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class FloatArrayFilterMessage {
    private @NonNull Long filterId;
    public @NonNull Long getFilterId() { return filterId; }
    public void setFilterId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"filterId\" is null.");
      }
      this.filterId = setterArg;
    }

    private @NonNull String name;
    public @NonNull String getName() { return name; }
    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull List<Double> value;
    public @NonNull List<Double> getValue() { return value; }
    public void setValue(@NonNull List<Double> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"value\" is null.");
      }
      this.value = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private FloatArrayFilterMessage() {}
    public static final class Builder {
      private @Nullable Long filterId;
      public @NonNull Builder setFilterId(@NonNull Long setterArg) {
        this.filterId = setterArg;
        return this;
      }
      private @Nullable String name;
      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }
      private @Nullable List<Double> value;
      public @NonNull Builder setValue(@NonNull List<Double> setterArg) {
        this.value = setterArg;
        return this;
      }
      public @NonNull FloatArrayFilterMessage build() {
        FloatArrayFilterMessage pigeonReturn = new FloatArrayFilterMessage();
        pigeonReturn.setFilterId(filterId);
        pigeonReturn.setName(name);
        pigeonReturn.setValue(value);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("filterId", filterId);
      toMapResult.put("name", name);
      toMapResult.put("value", value);
      return toMapResult;
    }
    static @NonNull FloatArrayFilterMessage fromMap(@NonNull Map<String, Object> map) {
      FloatArrayFilterMessage pigeonResult = new FloatArrayFilterMessage();
      Object filterId = map.get("filterId");
      pigeonResult.setFilterId((filterId == null) ? null : ((filterId instanceof Integer) ? (Integer)filterId : (Long)filterId));
      Object name = map.get("name");
      pigeonResult.setName((String)name);
      Object value = map.get("value");
      pigeonResult.setValue((List<Double>)value);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class SourceFilterMessage {
    private @NonNull Long filterId;
    public @NonNull Long getFilterId() { return filterId; }
    public void setFilterId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"filterId\" is null.");
      }
      this.filterId = setterArg;
    }

    private @NonNull String path;
    public @NonNull String getPath() { return path; }
    public void setPath(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"path\" is null.");
      }
      this.path = setterArg;
    }

    private @NonNull Boolean asset;
    public @NonNull Boolean getAsset() { return asset; }
    public void setAsset(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"asset\" is null.");
      }
      this.asset = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private SourceFilterMessage() {}
    public static final class Builder {
      private @Nullable Long filterId;
      public @NonNull Builder setFilterId(@NonNull Long setterArg) {
        this.filterId = setterArg;
        return this;
      }
      private @Nullable String path;
      public @NonNull Builder setPath(@NonNull String setterArg) {
        this.path = setterArg;
        return this;
      }
      private @Nullable Boolean asset;
      public @NonNull Builder setAsset(@NonNull Boolean setterArg) {
        this.asset = setterArg;
        return this;
      }
      public @NonNull SourceFilterMessage build() {
        SourceFilterMessage pigeonReturn = new SourceFilterMessage();
        pigeonReturn.setFilterId(filterId);
        pigeonReturn.setPath(path);
        pigeonReturn.setAsset(asset);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("filterId", filterId);
      toMapResult.put("path", path);
      toMapResult.put("asset", asset);
      return toMapResult;
    }
    static @NonNull SourceFilterMessage fromMap(@NonNull Map<String, Object> map) {
      SourceFilterMessage pigeonResult = new SourceFilterMessage();
      Object filterId = map.get("filterId");
      pigeonResult.setFilterId((filterId == null) ? null : ((filterId instanceof Integer) ? (Integer)filterId : (Long)filterId));
      Object path = map.get("path");
      pigeonResult.setPath((String)path);
      Object asset = map.get("asset");
      pigeonResult.setAsset((Boolean)asset);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class BitmapFilterMessage {
    private @NonNull Long filterId;
    public @NonNull Long getFilterId() { return filterId; }
    public void setFilterId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"filterId\" is null.");
      }
      this.filterId = setterArg;
    }

    private @NonNull String name;
    public @NonNull String getName() { return name; }
    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull String path;
    public @NonNull String getPath() { return path; }
    public void setPath(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"path\" is null.");
      }
      this.path = setterArg;
    }

    private @NonNull Boolean asset;
    public @NonNull Boolean getAsset() { return asset; }
    public void setAsset(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"asset\" is null.");
      }
      this.asset = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private BitmapFilterMessage() {}
    public static final class Builder {
      private @Nullable Long filterId;
      public @NonNull Builder setFilterId(@NonNull Long setterArg) {
        this.filterId = setterArg;
        return this;
      }
      private @Nullable String name;
      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }
      private @Nullable String path;
      public @NonNull Builder setPath(@NonNull String setterArg) {
        this.path = setterArg;
        return this;
      }
      private @Nullable Boolean asset;
      public @NonNull Builder setAsset(@NonNull Boolean setterArg) {
        this.asset = setterArg;
        return this;
      }
      public @NonNull BitmapFilterMessage build() {
        BitmapFilterMessage pigeonReturn = new BitmapFilterMessage();
        pigeonReturn.setFilterId(filterId);
        pigeonReturn.setName(name);
        pigeonReturn.setPath(path);
        pigeonReturn.setAsset(asset);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("filterId", filterId);
      toMapResult.put("name", name);
      toMapResult.put("path", path);
      toMapResult.put("asset", asset);
      return toMapResult;
    }
    static @NonNull BitmapFilterMessage fromMap(@NonNull Map<String, Object> map) {
      BitmapFilterMessage pigeonResult = new BitmapFilterMessage();
      Object filterId = map.get("filterId");
      pigeonResult.setFilterId((filterId == null) ? null : ((filterId instanceof Integer) ? (Integer)filterId : (Long)filterId));
      Object name = map.get("name");
      pigeonResult.setName((String)name);
      Object path = map.get("path");
      pigeonResult.setPath((String)path);
      Object asset = map.get("asset");
      pigeonResult.setAsset((Boolean)asset);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class BitmapDataFilterMessage {
    private @NonNull Long filterId;
    public @NonNull Long getFilterId() { return filterId; }
    public void setFilterId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"filterId\" is null.");
      }
      this.filterId = setterArg;
    }

    private @NonNull String name;
    public @NonNull String getName() { return name; }
    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull byte[] data;
    public @NonNull byte[] getData() { return data; }
    public void setData(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"data\" is null.");
      }
      this.data = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private BitmapDataFilterMessage() {}
    public static final class Builder {
      private @Nullable Long filterId;
      public @NonNull Builder setFilterId(@NonNull Long setterArg) {
        this.filterId = setterArg;
        return this;
      }
      private @Nullable String name;
      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }
      private @Nullable byte[] data;
      public @NonNull Builder setData(@NonNull byte[] setterArg) {
        this.data = setterArg;
        return this;
      }
      public @NonNull BitmapDataFilterMessage build() {
        BitmapDataFilterMessage pigeonReturn = new BitmapDataFilterMessage();
        pigeonReturn.setFilterId(filterId);
        pigeonReturn.setName(name);
        pigeonReturn.setData(data);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("filterId", filterId);
      toMapResult.put("name", name);
      toMapResult.put("data", data);
      return toMapResult;
    }
    static @NonNull BitmapDataFilterMessage fromMap(@NonNull Map<String, Object> map) {
      BitmapDataFilterMessage pigeonResult = new BitmapDataFilterMessage();
      Object filterId = map.get("filterId");
      pigeonResult.setFilterId((filterId == null) ? null : ((filterId instanceof Integer) ? (Integer)filterId : (Long)filterId));
      Object name = map.get("name");
      pigeonResult.setName((String)name);
      Object data = map.get("data");
      pigeonResult.setData((byte[])data);
      return pigeonResult;
    }
  }
  private static class FilterApiCodec extends StandardMessageCodec {
    public static final FilterApiCodec INSTANCE = new FilterApiCodec();
    private FilterApiCodec() {}
    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte)128:         
          return BitmapDataFilterMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)129:         
          return BitmapFilterMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)130:         
          return CreateFilterMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)131:         
          return FilterMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)132:         
          return FloatArrayFilterMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)133:         
          return FloatFilterMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)134:         
          return SourceFilterMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        default:        
          return super.readValueOfType(type, buffer);
        
      }
    }
    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value)     {
      if (value instanceof BitmapDataFilterMessage) {
        stream.write(128);
        writeValue(stream, ((BitmapDataFilterMessage) value).toMap());
      } else 
      if (value instanceof BitmapFilterMessage) {
        stream.write(129);
        writeValue(stream, ((BitmapFilterMessage) value).toMap());
      } else 
      if (value instanceof CreateFilterMessage) {
        stream.write(130);
        writeValue(stream, ((CreateFilterMessage) value).toMap());
      } else 
      if (value instanceof FilterMessage) {
        stream.write(131);
        writeValue(stream, ((FilterMessage) value).toMap());
      } else 
      if (value instanceof FloatArrayFilterMessage) {
        stream.write(132);
        writeValue(stream, ((FloatArrayFilterMessage) value).toMap());
      } else 
      if (value instanceof FloatFilterMessage) {
        stream.write(133);
        writeValue(stream, ((FloatFilterMessage) value).toMap());
      } else 
      if (value instanceof SourceFilterMessage) {
        stream.write(134);
        writeValue(stream, ((SourceFilterMessage) value).toMap());
      } else 
{
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface FilterApi {
    @NonNull FilterMessage create(@NonNull CreateFilterMessage msg);
    void setSource(@NonNull SourceFilterMessage msg);
    void setFloatParameter(@NonNull FloatFilterMessage msg);
    void setFloatArrayParameter(@NonNull FloatArrayFilterMessage msg);
    void setBitmapParameter(@NonNull BitmapFilterMessage msg);
    void setBitmapDataParameter(@NonNull BitmapDataFilterMessage msg);
    void dispose(@NonNull FilterMessage msg);

    /** The codec used by FilterApi. */
    static MessageCodec<Object> getCodec() {
      return       FilterApiCodec.INSTANCE;    }
    /**Sets up an instance of `FilterApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, FilterApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.FilterApi.create", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              CreateFilterMessage msgArg = (CreateFilterMessage)args.get(0);
              if (msgArg == null) {
                throw new NullPointerException("msgArg unexpectedly null.");
              }
              FilterMessage output = api.create(msgArg);
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.FilterApi.setSource", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              SourceFilterMessage msgArg = (SourceFilterMessage)args.get(0);
              if (msgArg == null) {
                throw new NullPointerException("msgArg unexpectedly null.");
              }
              api.setSource(msgArg);
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.FilterApi.setFloatParameter", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              FloatFilterMessage msgArg = (FloatFilterMessage)args.get(0);
              if (msgArg == null) {
                throw new NullPointerException("msgArg unexpectedly null.");
              }
              api.setFloatParameter(msgArg);
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.FilterApi.setFloatArrayParameter", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              FloatArrayFilterMessage msgArg = (FloatArrayFilterMessage)args.get(0);
              if (msgArg == null) {
                throw new NullPointerException("msgArg unexpectedly null.");
              }
              api.setFloatArrayParameter(msgArg);
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.FilterApi.setBitmapParameter", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              BitmapFilterMessage msgArg = (BitmapFilterMessage)args.get(0);
              if (msgArg == null) {
                throw new NullPointerException("msgArg unexpectedly null.");
              }
              api.setBitmapParameter(msgArg);
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.FilterApi.setBitmapDataParameter", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              BitmapDataFilterMessage msgArg = (BitmapDataFilterMessage)args.get(0);
              if (msgArg == null) {
                throw new NullPointerException("msgArg unexpectedly null.");
              }
              api.setBitmapDataParameter(msgArg);
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.FilterApi.dispose", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              FilterMessage msgArg = (FilterMessage)args.get(0);
              if (msgArg == null) {
                throw new NullPointerException("msgArg unexpectedly null.");
              }
              api.dispose(msgArg);
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  @NonNull private static Map<String, Object> wrapError(@NonNull Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorMap;
  }
}
